// 메인페이지 로직 코드

import 'dart:async'; // 비동기(Stream)를 위해 추가
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart'; // 만보기 플러그인
import 'package:permission_handler/permission_handler.dart'; // 권한 핸들러
import 'package:running_ham/screens/main_screen/main_screen_ui.dart'; // UI 파일
import 'main_screen_widget.dart'; // 헬퍼 함수
import 'package:firebase_auth/firebase_auth.dart'; // Firebase 로그인
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase DB

// 햄스터 상태를 종류별로 정의
enum HamsterState {
  normal, // 기본
  fat1, // 1단계 살찜
  fat2, // 2단계 살찜
}

// 로직 담당 StatefulWidget
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// 로직을 담당하는 State 클래스
class _MainScreenState extends State<MainScreen> {

  StreamSubscription<StepCount>?
      _stepCountStreamSubscription; // 스트림 구독 객체
  int _steps = 0; // 현재 걸음 수 0

  // 햄스터 상태 저장할 변수
  HamsterState _hamsterState = HamsterState.normal; // 기본 상태로 시작
  final int _targetSteps = 5000; // 목표 설음 수 (나중에 10000보 추가)

  String? _userId; // 발급받은 유저 ID 저장할 변수

  // Firestore 인스턴스
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseAndLogin(); // 앱 시작 시, 로직 실행
  }

  @override
  void dispose() {
    _stepCountStreamSubscription?.cancel(); // 앱 종료 시 스트림 구독 취소
    _saveUserData(); // 유저 데이터 저장

    super.dispose();
  }

  // 초기화 및 익명 로그인 함수
  Future<void> _initializeFirebaseAndLogin() async {
    try {
      //  익명으로 로그인 시도
      final userCredential = await FirebaseAuth.instance.signInAnonymously();

      // 로그인 성공 시 고유 ID)를 변수에 저장
      _userId = userCredential.user?.uid;
      print("익명 로그인 성공! 유저 ID: $_userId"); // 터미널에 로그 찍기

      if (_userId != null && mounted) {
        await _loadUserData(); // 유저 데이터 불러오기
        initPlatformState(); // 만보기 센서 연결 함수 호출
      } else {
        // ID 발급 실패 시
        if (mounted) setState(() => _steps = -3); // 로그인 실패 에러
      }
    } catch (e) {
      print("파이어베이스 익명 로그인 에러: $e");
      if (mounted) setState(() => _steps = -3); // 로그인 실패 에러
    }
  }

  // 만보기 센서 연결 함수
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
      // 권한이 거부되면 걸음 수를 -1 에러로 표시
      if (mounted) {
        setState(() {
          _steps = -1; // 권한 없음 에러
        });
      }
    }
  }

  // 만보기 스트림 시작 함수
  void startListening() {
    _stepCountStreamSubscription =
        Pedometer.stepCountStream.listen((StepCount event) {
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
      // 에러 처리
      print("만보기 에러: $error");
      if (mounted) {
        setState(() {
          _steps = -2; // 센서 에러
        });
      }
    });
  }

  // 데이터 저장 함수
  Future<void> _saveUserData() async {
    if (_userId == null) return; // 비 로그인 시 저장 안 함

    try {
      // users 컬렉션에 _userId 문서로 데이터 저장
      await db.collection('users').doc(_userId).set({
        'steps': _steps, // 현재 걸음 수
        'hamsterState': _hamsterState.toString(), // 현재 햄스터 상태
        'lastSaved': FieldValue.serverTimestamp(), // 마지막 저장 시간 (서버 시간 기준)
      }, SetOptions(merge: true)); // 덮어쓰되, 기존 필드 유지
      print("[$_userId] 데이터 저장 성공: $_steps 보");
    } catch (e) {
      print("Firestore DB 저장 에러: $e");
    }
  }

  // 데이터 불러오기 함수
  Future<void> _loadUserData() async {
    if (_userId == null) return; // 비 로그인 시 불러오기 안 함

    try {
      // users 컬렉션에서 _userId 문서를 가져옴
      final docSnap = await db.collection('users').doc(_userId).get();

      if (docSnap.exists && mounted) {
        Map<String, dynamic> data = docSnap.data()!;
        
        setState(() { // setState로 UI 갱신
          // DB 데이터로 로컬 변수 복원
          _steps = data['steps'] ?? 0; // null일 경우 0으로
          
          String savedState = data['hamsterState'] ?? 'HamsterState.normal';
          // 문자열을 다시 enum으로 변환
          _hamsterState = HamsterState.values.firstWhere(
              (e) => e.toString() == savedState,
              orElse: () => HamsterState.normal); // 못찾으면 기본값
        });
        print("🔄 [$_userId] 데이터 불러오기/복원 성공: $_steps 보");
        
      } else { // 데이터가 없다면 → 신규 유저
        print("[$_userId] 신규 유저. DB에 데이터 없음.");
        // 기본값으로 _saveUserData 한번 호출해서 초기 문서 생성 가능
      }
    } catch (e) {
      print("Firestore DB 불러오기 에러: $e");
    }
  }

  // build 함수 (UI 그리는 부분)
  @override
  Widget build(BuildContext context) {
    // 로직 파일은 UI 파일 조립
    return MainScreenUI(
      steps: _steps, // 현재 걸음 수 전달
      hamsterState: _hamsterState, // 현재 햄스터 상태 전달
    );
  }
}