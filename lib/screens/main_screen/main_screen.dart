// 메인페이지 로직 코드

import 'dart:async'; // 비동기(Stream)를 위해 추가
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart'; // 만보기 플러그인
import 'package:permission_handler/permission_handler.dart'; // 권한 핸들러
import 'package:running_ham/screens/main_screen/main_screen_ui.dart'; // UI 파일
import 'main_screen_widget.dart'; // 헬퍼 함수
import 'package:firebase_auth/firebase_auth.dart'; // Firebase 로그인
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase DB
import 'package:intl/intl.dart'; // 날짜 비교용

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

  // 연속 및 재화 로직을 위한 변수
  int _continuousFailureDays = 0; // 연속 실패일
  int _seedCount = 0; // 재화 (도토리)
  String _lastRewardDateKey = ''; // 마지막으로 보상받은 날짜 (yyyyMMdd)

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
        await _loadAndProcessUserData(); // 유저 데이터 불러오기 + 날짜 처리
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
    // 오늘 날짜 키
    final String todayKey = DateFormat('yyyyMMdd').format(DateTime.now());
    _stepCountStreamSubscription =
        Pedometer.stepCountStream.listen((StepCount event) {
      if (!mounted) return; // 위젯이 화면에 없으면 중단

      // 걸음 수 업데이트
final newSteps = event.steps;

      setState(() {
        _steps = newSteps; // 상태 변수에 최신 걸음 수를 업데이트

        // 살찌는 로직 + 연속 로직과 연동
        if (_steps < _targetSteps) {
          // 목표(5000보) 미달 시
          if (_continuousFailureDays >= 2) {
            _hamsterState = HamsterState.fat2; // 연속 2일 이상 실패 시 fat2
          } else {
            _hamsterState = HamsterState.fat1; // 그 외에는 fat1
          }
        } else {
          // 목표 달성 시
          _hamsterState = HamsterState.normal;
        }

        // 재화 로직
        // 5000보 달성 오늘 보상을 아직 안 받았다면
        if (_steps >= _targetSteps && _lastRewardDateKey != todayKey) {
          _seedCount += 50; // 재화 (도토리) 50개 획득
          _lastRewardDateKey = todayKey; // 오늘 보상 받음으로 처리
          print("5000보 달성! 도토리 50개 획득! (총: $_seedCount 개)");
        }
      });

      // 걸음 수, 상태가 변경될 때마다 DB에 저장
      _saveUserData();

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

  // 햄스터 상태 문자열을 enum으로 변환
  HamsterState _parseHamsterState(String? stateStr) {
    return HamsterState.values.firstWhere(
        (e) => e.toString() == stateStr,
        orElse: () => HamsterState.normal); // 못찾으면 기본값
  }

  // [4단계] 데이터 '불러오기' 및 '날짜 처리' (핵심 로직)
  Future<void> _loadAndProcessUserData() async {
    if (_userId == null) return;

    try {
      final docSnap = await db.collection('users').doc(_userId).get();
      final now = DateTime.now();
      final todayKey = DateFormat('yyyyMMdd').format(now);

      if (docSnap.exists && mounted) { // 저장된 데이터가 있다면
        Map<String, dynamic> data = docSnap.data()!;
        
        // DB 데이터 로컬 변수로 복원
        int yesterdaysSteps = data['steps'] ?? 0;
        _hamsterState = _parseHamsterState(data['hamsterState']);
        _continuousFailureDays = data['continuousFailureDays'] ?? 0;
        _seedCount = data['seedCount'] ?? 0;
        _lastRewardDateKey = data['lastRewardDateKey'] ?? '';
        
        final Timestamp? lastSavedTimestamp = data['lastSaved'];
        
        // (2) 날짜 비교 로직
        if (lastSavedTimestamp != null) {
          final lastSavedDate = lastSavedTimestamp.toDate();
          final lastSavedKey = DateFormat('yyyyMMdd').format(lastSavedDate);

          if (lastSavedKey != todayKey) { // 새로운 날이 되었다면
            print("새로운 날입니다! 어제 걸음 수를 정산합니다.");
            // 어제 날짜로 정산 시작
            _steps = 0; // '오늘' 걸음 수는 0으로 초기화

            final daysDifference = now.difference(lastSavedDate).inDays;

            if (daysDifference == 1) { // (정상) 하루 지남
              if (yesterdaysSteps < _targetSteps) {
                _continuousFailureDays++; // 어제 실패
              } else {
                _continuousFailureDays = 0; // 어제 성공 (연속 실패 리셋)
              }
            } else if (daysDifference > 1) { // (비정상) 2일 이상 미접속
              print("$daysDifference 일 이상 미접속!");
              _continuousFailureDays = 2; // 2일 이상 실패로 간주 (fat2)
            }

            // 연속 실패에 따른 오늘 햄스터 상태 결정
            if (_continuousFailureDays >= 2) {
              _hamsterState = HamsterState.fat2;
            } else if (_continuousFailureDays == 1) {
              _hamsterState = HamsterState.fat1;
            } else {
              _hamsterState = HamsterState.normal;
            }

          } else { // (같은 날)
            print("같은 날 재접속. 어제 걸음 수: $yesterdaysSteps");
            _steps = yesterdaysSteps; // 같은 날이면 DB 걸음 수 그대로 복원
          }
        } else {
           print("[$_userId] lastSaved 타임스탬프 없음. (신규 유저 혹은 구버전 데이터)");
           _steps = yesterdaysSteps;
        }

      } else { // 저장된 데이터가 없다면 (신규 유저)
        print("[$_userId] 신규 유저. DB에 데이터 없음.");
        // 모든 변수가 0, normal, '' (기본값)
      }

      // 최종적으로 로드, 처리된 데이터로 UI 갱신
      setState(() {});
      print("[$_userId] 데이터 불러오기/처리 성공: $_steps 보, $_continuousFailureDays 일 연속 실패, $_seedCount 도토리");

    } catch (e) {
      print("Firestore DB 불러오기 및 처리 에러: $e");
    }
  }

  // 데이터 저장 함수
  Future<void> _saveUserData() async {
    if (_userId == null) return; // 로그인 안됐으면 저장 안 함

    try {
      // users 컬렉션 안에, _userId 이름으로 데이터 저장
      await db.collection('users').doc(_userId).set({
        'steps': _steps, // 현재 걸음 수
        'hamsterState': _hamsterState.toString(), // 현재 햄스터 상태
        'lastSaved': FieldValue.serverTimestamp(), // 마지막 저장 시간 (서버 시간 기준)
        'continuousFailureDays': _continuousFailureDays, // 연속 실패일
        'seedCount': _seedCount, // 재화(도토리)
        'lastRewardDateKey': _lastRewardDateKey, // 마지막 보상 날짜
      }, SetOptions(merge: true)); // 덮어쓰되, 기존 필드 유지

    } catch (e) {
      print("Firestore DB 저장 에러: $e");
    }
  }
  // build 함수 (UI 그리는 부분)
  @override
  Widget build(BuildContext context) {
    // 로직 파일은 UI 파일 조립
    return MainScreenUI(
      steps: _steps, // 현재 걸음 수 전달
      hamsterState: _hamsterState, // 현재 햄스터 상태 전달
      seedCount: _seedCount, // 재화 (도토리) 전달
    );
  }
}