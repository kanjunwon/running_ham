import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 포맷팅
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  // Firebase 인스턴스
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _uid; // 사용자 고유 ID

  // 🎯 DB 저장 최적화용 타이머 (디바운싱)
  Timer? _saveDebounceTimer;

  // 내 정보
  int _seedCount = 0; // 도토리
  int _todaySteps = 0; // 오늘 걸음 수
  int _attendanceDays = 0; // 출석 일수

  String _nickname = ""; // 닉네임 (튜토리얼에서 설정)
  String _hamsterImage =
      "assets/images/main_images/ham_1.png"; // 햄스터 본체 (기본 이미지)

  // 현재 햄스터 상태 (메인 페이지에서 업데이트)
  String _currentHamsterState = 'normal'; // normal, fat1, fat2

  // 현재 햄스터 색상 (염색권 사용 시 변경)
  String _hamsterColor = 'default'; // default, black, pink, sky

  String _exemptionDate = ""; // 운동 면제권 날짜 (yyyyMMdd)

  // 개발자 모드 (이스터에그)
  bool _isDevMode = false;

  // 햄스터 뚱뚱 레벨 (0: normal, 1: fat1, 2: fat2)
  int _fatLevel = 0;
  String _lastCheckedDate = ""; // 마지막으로 체크한 날짜

  // 기록페이지 걸음 수
  Map<String, int> _stepHistory = {};

  // 아이템 정보
  List<String> _myInventory = []; // 내가 가진 아이템 ID 리스트

  // 현재 장착 중인 아이템
  Map<String, String> _equippedItems = {
    'bowl': 'assets/images/main_images/food_normal_back.png', // 기본 밥그릇
    'water': 'assets/images/main_images/water_normal_back.png', // 기본 물통
    'wheel': 'assets/images/main_images/chat_normal_back.png', // 기본 챗바퀴
    'glass': '', // 선글라스
    'hair': '', // 머리핀
  };

  // 익명 로그인 + 데이터 불러오기
  Future<void> initializeUser() async {
    try {
      // 익명 로그인 (이미 로그인되어 있으면 기존 계정 사용)
      if (_auth.currentUser == null) {
        await _auth.signInAnonymously();
      }
      _uid = _auth.currentUser?.uid;

      if (_uid != null) {
        // Firestore에서 데이터 불러오기
        await _loadDataFromFirestore();
      }
    } catch (e) {
      debugPrint('Firebase 초기화 오류: $e');
    }
  }

  // Firestore에서 데이터 불러오기
  Future<void> _loadDataFromFirestore() async {
    if (_uid == null) return;

    try {
      final doc = await _firestore.collection('users').doc(_uid).get();

      if (doc.exists) {
        final data = doc.data()!;
        _seedCount = data['seedCount'] ?? 0;
        _nickname = data['nickname'] ?? '';
        _attendanceDays = data['attendanceDays'] ?? 0;
        _hamsterColor = data['hamsterColor'] ?? 'default';
        _exemptionDate = data['exemptionDate'] ?? '';
        _fatLevel = data['fatLevel'] ?? 0;
        _lastCheckedDate = data['lastCheckedDate'] ?? '';
        _myInventory = List<String>.from(data['myInventory'] ?? []);
        _equippedItems = Map<String, String>.from(
          data['equippedItems'] ??
              {
                'bowl': 'assets/images/main_images/food_normal_back.png',
                'water': 'assets/images/main_images/water_normal_back.png',
                'wheel': 'assets/images/main_images/chat_normal_back.png',
                'glass': '',
                'hair': '',
              },
        );
        _stepHistory = Map<String, int>.from(data['stepHistory'] ?? {});

        // 어제 걸음 수 체크해서 햄스터 상태 업데이트
        _checkYesterdaySteps();

        notifyListeners();
      }
    } catch (e) {
      debugPrint('데이터 불러오기 오류: $e');
    }
  }

  // Firestore에 데이터 저장 (즉시 저장)
  Future<void> _saveDataToFirestore() async {
    if (_uid == null) return;

    try {
      await _firestore.collection('users').doc(_uid).set({
        'seedCount': _seedCount,
        'nickname': _nickname,
        'attendanceDays': _attendanceDays,
        'hamsterColor': _hamsterColor,
        'exemptionDate': _exemptionDate,
        'fatLevel': _fatLevel,
        'lastCheckedDate': _lastCheckedDate,
        'myInventory': _myInventory,
        'equippedItems': _equippedItems,
        'stepHistory': _stepHistory,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('데이터 저장 오류: $e');
    }
  }

  // 🎯 디바운싱된 저장 (걸음 수 업데이트용 - 10초 후 저장)
  void _debouncedSave() {
    _saveDebounceTimer?.cancel(); // 기존 타이머 취소
    _saveDebounceTimer = Timer(const Duration(seconds: 10), () {
      _saveDataToFirestore();
    });
  }

  // 🎯 타이머 정리 (앱 종료 시 호출)
  @override
  void dispose() {
    _saveDebounceTimer?.cancel();
    // 마지막 데이터 저장
    _saveDataToFirestore();
    super.dispose();
  }

  // 데이터 가져오기
  int get seedCount => _seedCount;
  int get todaySteps => _todaySteps;
  int get attendanceDays => _attendanceDays;
  String get nickname => _nickname;
  String get hamsterImage => _hamsterImage;
  String get currentHamsterState => _currentHamsterState; // 현재 햄스터 상태
  String get hamsterColor => _hamsterColor; // 현재 햄스터 색상
  bool get isDevMode => _isDevMode; // 개발자 모드 여부
  int get fatLevel => _fatLevel; // 햄스터 뚱뚱 레벨
  List<String> get myInventory => _myInventory;
  Map<String, String> get equippedItems => _equippedItems;
  Map<String, int> get stepHistory => _stepHistory;

  // 오늘이 운동 면제인지 확인하는 함수
  bool get isExemptToday {
    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    return _exemptionDate == today;
  }

  // 어제 걸음 수 체크해서 햄스터 상태 업데이트 + 출석 일수 증가
  void _checkYesterdaySteps() {
    final today = DateFormat('yyyyMMdd').format(DateTime.now());

    // 오늘 이미 체크했으면 스킵
    if (_lastCheckedDate == today) return;

    // 🎯 출석 일수 증가 (새로운 날이 시작되면 +1)
    _attendanceDays++;

    // 어제 날짜 계산
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayKey = DateFormat('yyyyMMdd').format(yesterday);

    // 어제 걸음 수 확인
    final yesterdaySteps = _stepHistory[yesterdayKey] ?? 0;

    // 어제가 면제일이었는지 확인 (면제일이면 미달로 안 침)
    final wasExemptYesterday = _exemptionDate == yesterdayKey;

    if (!wasExemptYesterday && yesterdaySteps < 5000) {
      // 어제 5000보 미달 → fatLevel 증가 (최대 2)
      _fatLevel = (_fatLevel + 1).clamp(0, 2);
    }
    // 어제 5000보 이상이면 fatLevel은 그대로 유지 (오늘 달성해야 복구)

    _lastCheckedDate = today;

    // 햄스터 상태 업데이트
    _updateHamsterStateFromFatLevel();
  }

  // fatLevel에 따라 햄스터 상태 설정
  void _updateHamsterStateFromFatLevel() {
    switch (_fatLevel) {
      case 0:
        _currentHamsterState = 'normal';
        break;
      case 1:
        _currentHamsterState = 'fat1';
        break;
      case 2:
        _currentHamsterState = 'fat2';
        break;
    }
  }

  // 오늘 5000보 달성 시 호출 → fatLevel 한 단계 감소
  void achieveDailyGoal() {
    if (_fatLevel > 0) {
      _fatLevel--; // 🎯 한 단계만 감소 (fat2 → fat1 → normal)
      _updateHamsterStateFromFatLevel();
      notifyListeners();
      _saveDataToFirestore();
    }
  }

  // 개발자 모드: 햄스터 살찌게 (fatLevel +1)
  void devMakeFat() {
    _fatLevel = (_fatLevel + 1).clamp(0, 2);
    _updateHamsterStateFromFatLevel();
    notifyListeners();
    _saveDataToFirestore();
  }

  // 개발자 모드: 햄스터 날씬하게 (fatLevel 한 단계 감소)
  void devMakeSlim() {
    if (_fatLevel > 0) {
      _fatLevel--; // 🎯 한 단계만 감소 (fat2 → fat1 → normal)
      _updateHamsterStateFromFatLevel();
      notifyListeners();
      _saveDataToFirestore();
    }
  }

  // 데이터 초기화 (죽음)
  Future<void> resetData() async {
    _nickname = "새로운 햄스터"; // 임시 이름
    _seedCount = 0; // 돈 초기화
    _todaySteps = 0;
    _attendanceDays = 1;
    _hamsterColor = 'default'; // 색상 초기화
    _fatLevel = 0; // 뚱뚱 레벨 초기화
    _lastCheckedDate = ""; // 체크 날짜 초기화
    _currentHamsterState = 'normal'; // 햄스터 상태 초기화

    // 인벤토리 비우기
    _myInventory.clear();

    // 장착 아이템 기본값으로 복구
    _equippedItems = {
      'bowl': 'assets/images/main_images/food_normal_back.png',
      'water': 'assets/images/main_images/water_normal_back.png',
      'wheel': 'assets/images/main_images/chat_normal_back.png',
      'glass': '',
      'hair': '',
    };

    // 햄스터 이미지도 기본으로
    _hamsterImage = "assets/images/main_images/ham_1.png";

    notifyListeners(); // 화면 갱신
    await _saveDataToFirestore(); // Firebase 저장
  }

  // 닉네임 설정
  void setNickname(String newName) {
    _nickname = newName;

    // 개발자 모드
    const devNames = ['간준원', '오은채', '송지호'];
    if (devNames.contains(newName)) {
      _isDevMode = true;
    }

    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
  }

  // 튜토리얼 완료 처리
  Future<void> completeTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    // 🎯 첫 출석 일수 설정 (1일차 시작)
    _attendanceDays = 1;
    _lastCheckedDate = DateFormat('yyyyMMdd').format(DateTime.now());

    notifyListeners();
    await _saveDataToFirestore(); // Firebase 저장
  }

  // 걸음 수 업데이트 (🎯 디바운싱 적용 - 10초 후 저장)
  void updateSteps(int steps) {
    _todaySteps = steps;

    // 오늘 날짜 기록
    final String todayKey = DateFormat('yyyyMMdd').format(DateTime.now());
    _stepHistory[todayKey] = steps;

    notifyListeners(); // 화면 갱신 알림
    _debouncedSave(); // 🎯 디바운싱된 저장 (매번 저장 X, 10초 후 저장)
  }

  // 아이템 구매
  bool buyItem(String itemId, int price) {
    if (_myInventory.contains(itemId)) return false; // 이미 있음
    if (_seedCount < price) return false; // 돈 부족

    _seedCount -= price; // 돈 깎기
    _myInventory.add(itemId); // 가방에 넣기
    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
    return true; // 구매 성공
  }

  // 아이템 장착
  void equipItem(String category, String imagePath) {
    // 액세서리는 이미 낀거 또 누르면 해제
    if (category == 'glass' && _equippedItems['glass'] == imagePath) {
      _equippedItems['glass'] = '';
    } else if (category == 'hair' && _equippedItems['hair'] == imagePath) {
      _equippedItems['hair'] = '';
    } else {
      // 아니면 장착
      _equippedItems[category] = imagePath;
    }
    notifyListeners(); // 화면 갱신 알림
    _saveDataToFirestore(); // Firebase 저장
  }

  // 도토리 획득
  void earnSeeds(int amount) {
    _seedCount += amount;
    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
  }

  // 닉네임 변경
  void changeNickname(String newName) {
    _nickname = newName;
    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
  }

  // 햄스터 스킨 변경
  void changeHamsterSkin(String newImagePath) {
    _hamsterImage = newImagePath;
    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
  }

  // 햄스터 상태 업데이트 (메인 페이지에서 호출) - 이건 저장 안함 (매번 계산됨)
  void updateHamsterState(String state) {
    _currentHamsterState = state;
    notifyListeners();
  }

  // 햄스터 색상 변경 (염색권 사용 시)
  void changeHamsterColor(String color) {
    _hamsterColor = color;
    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
  }

  // 운동 면제권 사용
  void useExemptionTicket() {
    _exemptionDate = DateFormat('yyyyMMdd').format(DateTime.now());
    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
  }

  // 아이템 소모 (사용 시 인벤토리에서 삭제)
  void consumeItem(String itemId) {
    _myInventory.remove(itemId); // 인벤토리에서 삭제 → 상점에서 다시 구매 가능
    notifyListeners();
    _saveDataToFirestore(); // Firebase 저장
  }
}
