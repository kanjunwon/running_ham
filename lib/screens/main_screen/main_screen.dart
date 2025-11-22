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
  HamsterState _hamsterState = HamsterState.normal;
  final int _targetSteps = 5; // 원래 5000보

  // 보상 중복 방지용 로컬 변수
  String _lastRewardDateKey = '';

  @override
  void initState() {
    super.initState();
    initPlatformState(); // 로그인 과정 없이 바로 센서 켜기
  }

  @override
  void dispose() {
    _stepCountStreamSubscription?.cancel();
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

  // 만보기 스트림
  void startListening() {
    final String todayKey = DateFormat('yyyyMMdd').format(DateTime.now());

    _stepCountStreamSubscription = Pedometer.stepCountStream.listen(
      (StepCount event) {
        if (!mounted) return;

        setState(() {
          _steps = event.steps;

          // 햄스터 상태 로직
          if (_steps < _targetSteps) {
            _hamsterState = HamsterState.fat1;
          } else {
            _hamsterState = HamsterState.normal;
          }

          // 재화 획득 로직
          if (_steps >= _targetSteps && _lastRewardDateKey != todayKey) {
            context.read<UserProvider>().earnSeeds(50);

            _lastRewardDateKey = todayKey;
            print("5000보 달성! 도토리 획득!");
          }
        });

        context.read<UserProvider>().updateSteps(_steps);
      },
      onError: (error) {
        print("만보기 에러: $error");
        if (mounted) setState(() => _steps = -2);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return MainScreenUI(
      steps: _steps,
      hamsterState: _hamsterState,
      seedCount: userProvider.seedCount,
    );
  }
}
