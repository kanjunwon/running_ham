import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart'; // ★ Provider 추가
import 'package:intl/intl.dart';

import 'package:running_ham/providers/user_provider.dart'; // ★ 뇌(Provider) 가져오기
import 'main_screen_ui.dart';

enum HamsterState { normal, fat1, fat2 }

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StreamSubscription<StepCount>? _stepCountStreamSubscription;

  // [로컬 데이터] 걸음 수랑 햄스터 상태는 매일 변하니까 여기서 관리
  int _steps = 0;
  HamsterState _hamsterState = HamsterState.normal;
  final int _targetSteps = 5000;

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

          // 1. 햄스터 상태 로직 (단순화)
          if (_steps < _targetSteps) {
            _hamsterState = HamsterState.fat1;
          } else {
            _hamsterState = HamsterState.normal;
          }

          // 2. 재화 획득 로직 (Provider 사용!)
          if (_steps >= _targetSteps && _lastRewardDateKey != todayKey) {
            // ★ 뇌(Provider)한테 "돈 올려줘!" 라고 명령
            context.read<UserProvider>().earnSeeds(50);

            _lastRewardDateKey = todayKey;
            print("🎉 5000보 달성! 도토리 획득!");
          }
        });
      },
      onError: (error) {
        print("만보기 에러: $error");
        if (mounted) setState(() => _steps = -2);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ★ 뇌(Provider)를 감시해서 도토리 개수가 바뀌면 화면 다시 그림
    final userProvider = context.watch<UserProvider>();

    return MainScreenUI(
      steps: _steps,
      hamsterState: _hamsterState,
      seedCount: userProvider.seedCount, // ★ Provider에 있는 진짜 돈 보여주기
    );
  }
}
