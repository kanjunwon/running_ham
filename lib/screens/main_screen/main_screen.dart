import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'main_screen_ui.dart';

// 햄스터 상태를 종류별로 정의
enum HamsterState { normal, fat1, fat2 }

// 로직 담당 StatefulWidget
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// 로직을 담당하는 State 클래스
class _MainScreenState extends State<MainScreen> {
  StreamSubscription<StepCount>? _stepCountStreamSubscription;

  // 로컬 데이터 DB가 아닌, 매일 초기화되는 변수
  int _steps = 0;
  HamsterState _hamsterState = HamsterState.normal; // 기본값 (Provider에서 덮어씀)
  final int _targetSteps = 5000; // 목표 걸음 수
  String _lastRewardDateKey = '';

  // 터치 변수
  int _touchCount = 0; // 햄스터 터치 카운트 (상호작용)
  bool _isHappyMode = false; // 햄스터 해피 모드 여부
  Timer? _happyModeTimer; // 해피 모드 2초 타이머

  @override
  void initState() {
    super.initState();

    // Provider에서 초기 햄스터 상태 읽어오기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<UserProvider>().currentHamsterState;
      setState(() {
        _hamsterState = HamsterState.values.firstWhere(
          (e) => e.name == state,
          orElse: () => HamsterState.fat2,
        );
      });
    });

    initPlatformState(); // 로그인 과정 없이 바로 센서 켜기
  }

  // 이미지 미리 로딩
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage('assets/images/main_images/heart.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images/main_images/blush.png'),
      context,
    );
    // 가구들 미리 로딩
    final userProvider = context.read<UserProvider>();
    final equipped = userProvider.equippedItems;

    if (equipped['bowl'] != null && equipped['bowl']!.isNotEmpty) {
      precacheImage(AssetImage(equipped['bowl']!), context);
    }
    if (equipped['water'] != null && equipped['water']!.isNotEmpty) {
      precacheImage(AssetImage(equipped['water']!), context);
    }
    if (equipped['wheel'] != null && equipped['wheel']!.isNotEmpty) {
      precacheImage(AssetImage(equipped['wheel']!), context);
    }
    // 액세서리도 필요하면 추가
    if (equipped['glass'] != null && equipped['glass']!.isNotEmpty) {
      precacheImage(AssetImage(equipped['glass']!), context);
    }
    if (equipped['hair'] != null && equipped['hair']!.isNotEmpty) {
      precacheImage(AssetImage(equipped['hair']!), context);
    }
  }

  @override
  void dispose() {
    _stepCountStreamSubscription?.cancel();
    _happyModeTimer?.cancel(); // 타이머 취소
    super.dispose();
  }

  // 권한 요청 및 만보기 시작
  Future<void> initPlatformState() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      startListening();
    } else {
      if (mounted) setState(() => _steps = -1); // 권한 없음
    }
  }

  // 햄스터 터치 로직
  void _onHamsterTap() {
    setState(() {
      _touchCount++;

      // 5번 터치하면?
      if (_touchCount >= 5) {
        _isHappyMode = true; // 이펙트 켜기
        _touchCount = 0; // 카운트 리셋 (다시 5번 누르게 하려면)

        // 기존 타이머 있으면 취소 (연타 방지)
        _happyModeTimer?.cancel();

        // 2초 뒤에 끄기
        _happyModeTimer = Timer(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _isHappyMode = false; // 이펙트 끄기
            });
          }
        });
      }
    });
  }

  // 만보기 스트림
  void startListening() {
    final String todayKey = DateFormat('yyyyMMdd').format(DateTime.now());

    _stepCountStreamSubscription = Pedometer.stepCountStream.listen(
      (StepCount event) {
        if (!mounted) return;

        // 운동 면제권 확인
        final isExempt = context.read<UserProvider>().isExemptToday;

        setState(() {
          _steps = event.steps;

          // 햄스터 상태 로직
          if (isExempt) {
            _hamsterState = HamsterState.normal; // 면제권 쓰면 정상
          } else {
            if (_steps >= _targetSteps) {
              _hamsterState = HamsterState.normal;
            } else if (_steps >= _targetSteps ~/ 2) {
              _hamsterState = HamsterState.fat1; // 2500 이상
            } else {
              _hamsterState = HamsterState.fat2; // 2500 미만 (더 살찜)
            }
          }

          // 재화 획득 로직
          if (_steps >= _targetSteps && _lastRewardDateKey != todayKey) {
            context.read<UserProvider>().earnSeeds(50);
            _lastRewardDateKey = todayKey;
          }
        });

        // Provider에 햄스터 상태 업데이트 (보관함에서 사용)
        context.read<UserProvider>().updateHamsterState(_hamsterState.name);
        context.read<UserProvider>().updateSteps(_steps);
      },
      onError: (error) {
        debugPrint("만보기 에러: $error");
        if (mounted) setState(() => _steps = -2);
      },
    );
  }

  // 개발자 모드: 도토리 추가
  void _addSeeds() {
    context.read<UserProvider>().earnSeeds(100);
  }

  // 개발자 모드: 걸음 수 추가
  void _addSteps() {
    final String todayKey = DateFormat('yyyyMMdd').format(DateTime.now());
    final isExempt = context.read<UserProvider>().isExemptToday;

    setState(() {
      _steps += 100;

      // 햄스터 상태 업데이트
      if (isExempt) {
        _hamsterState = HamsterState.normal;
      } else {
        if (_steps >= _targetSteps) {
          _hamsterState = HamsterState.normal;
        } else if (_steps >= _targetSteps ~/ 2) {
          _hamsterState = HamsterState.fat1;
        } else {
          _hamsterState = HamsterState.fat2;
        }
      }

      // 5000보 달성 시 50 도토리 보상
      if (_steps >= _targetSteps && _lastRewardDateKey != todayKey) {
        context.read<UserProvider>().earnSeeds(50);
        _lastRewardDateKey = todayKey;
      }

      // 10000보 달성 시 추가 50 도토리 보상 (총 100개)
      if (_steps >= 10000 && _lastRewardDateKey != '${todayKey}_10k') {
        context.read<UserProvider>().earnSeeds(50);
        _lastRewardDateKey = '${todayKey}_10k';
      }
    });

    // Provider 업데이트
    context.read<UserProvider>().updateHamsterState(_hamsterState.name);
    context.read<UserProvider>().updateSteps(_steps);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return MainScreenUI(
      steps: _steps, // 오늘 걸음수
      hamsterState: _hamsterState, // 햄스터 상태
      seedCount: userProvider.seedCount, // 도토리 개수
      isHappyMode: _isHappyMode, // 해피 모드 여부
      onHamsterTap: _onHamsterTap, // 햄스터 터치 콜백
      isDevMode: userProvider.isDevMode, // 개발자 모드 여부
      onAddSeeds: _addSeeds, // 개발자 모드: 도토리 추가
      onAddSteps: _addSteps, // 개발자 모드: 걸음 수 추가
    );
  }
}
