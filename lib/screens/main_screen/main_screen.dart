// 메인페이지 로직 코드

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:running_ham/screens/main_screen/main_screen_ui.dart'; 

// StatefulWidget
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// 로직을 담당하는 State 클래스
class _MainScreenState extends State<MainScreen> {
  StreamSubscription<StepCount>? _stepCountStreamSubscription;
  int _steps = 0; // 걸음 수 상태 변수

  @override
  void initState() {
    super.initState();
    initPlatformState(); // 로직 실행
  }

  // 권한 요청 및 센서 연결 로직
  Future<void> initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      startListening();
    } else {
      print("신체 활동 권한 거부됨");
      if (mounted) setState(() => _steps = -2);
    }
  }

  // 걸음 수 리스닝 로직
  void startListening() {
    _stepCountStreamSubscription = Pedometer.stepCountStream.listen((StepCount event) {
      if (!mounted) return;
      setState(() {
        _steps = event.steps;
      });
    }, onError: (error) {
      if (!mounted) return;
      print("만보기 에러: $error");
      setState(() {
        _steps = -1;
      });
    });
  }

  // 구독 취소 로직
  @override
  void dispose() {
    _stepCountStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 로직은 UI를 호출, 걸음 수(_steps) 데이터만 전달
    return MainScreenUI(steps: _steps);
  }
}