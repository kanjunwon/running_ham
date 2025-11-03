// 메인페이지 로직 코드

import 'dart:async';  // 비동기(Stream)를 위해 추가
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';  // 만보기 플러그인
import 'package:permission_handler/permission_handler.dart';  // 권한 핸들러
import 'package:running_ham/screens/main_screen/main_screen_ui.dart';   // UI 파일

// 햄스터 상태를 종류별로 정의
enum HamsterState {
  normal, // 기본
  fat1,   // 1단계 살찜
  fat2,   // 2단계 살찜
}

// 로직 담당 StatefulWidget
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// 로직을 담당하는 State 클래스
class _MainScreenState extends State<MainScreen> {
  // 상태 변수 및 스트림 선언
  late StreamSubscription<StepCount>
      _stepCountStreamSubscription; // 스트림 구독 객체
  int _steps = 0; // 현재 걸음 수 0

// 햄스터 상태 저장할 변수
HamsterState _hamsterState = HamsterState.normal; // 기본 상태로 시작
final int _targetSteps = 5000;  // 목표 설음 수 (나중에 10000보 추가)

  @override
  void initState() {
    super.initState();
    initPlatformState(); // 앱 시작 시, 로직 실행
  }

  @override
  void dispose() {
    _stepCountStreamSubscription.cancel(); // 앱 종료 시 스트림 구독 취소
    super.dispose();
  }

// 만보기 센서 연결 함수 (권한 확인 포함)
  Future<void> initPlatformState() async {
    // 신체 활동 권한부터 확인
    var status = await Permission.activityRecognition.status;
    if (status.isDenied) {
      // 만약 권한이 거부된 상태면, 요청 팝업 띄우기
      status = await Permission.activityRecognition.request();
    }

    // 권한이 허용되었을 때만 만보기 켜기
    if (status.isGranted) {
      startListening(); // 만보기 스트림 시작
    } else {
      // 권한이 거부되면 걸음 수를 -1 (에러)로 표시
      if (mounted) {
        setState(() {
          _steps = -1; // 권한 없음 에러
        });
      }
    }
  }

  // 만보기 스트림 시작 함수
  void startListening() {
    _stepCountStreamSubscription = Pedometer.stepCountStream.listen((StepCount event) {
      if (!mounted) return; // 위젯이 화면에 없으면 중단

      setState(() {
        _steps = event.steps; // 상태 변수에 최신 걸음 수를 업데이트

        // 살찌는 로직 - 걸음 수에 따라 햄스터 상태 판단
        if (_steps < _targetSteps) {
          // 목표(5000보) 미달 시
          _hamsterState = HamsterState.fat1;
        } else {
          // 목표 달성 시
          _hamsterState = HamsterState.normal;
        }
        // 연속 미달 시 fat2 로직은 나중에 추가
      });
    }, onError: (error) {
      // 에러 처리 (센서 없음 등)
      print("만보기 에러: $error");
      if (mounted) {
        setState(() {
          _steps = -2; // 센서 에러
        });
      }
    });
  }

  // build 함수 (UI 그리는 부분)
  @override
  Widget build(BuildContext context) {
    // '로직' 파일은 UI 파일을 조립만 함
    return MainScreenUI(
      steps: _steps, // 현재 걸음 수 전달
      hamsterState: _hamsterState, // 현재 햄스터 상태 전달
    );
  }
}