import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 포맷팅
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  // 내 정보
  int _seedCount = 300000; // 도토리 (테스트용 300000개)
  int _todaySteps = 0; // 오늘 걸음 수
  int _attendanceDays = 0; // 출석 일수

  String _nickname = ""; // 닉네임 (튜토리얼에서 설정)
  String _hamsterImage =
      "assets/images/main_images/ham_1.png"; // 햄스터 본체 (기본 이미지)

  // 현재 햄스터 상태 (메인 페이지에서 업데이트)
  String _currentHamsterState = 'normal'; // 'normal', 'fat1', 'fat2'

  String _exemptionDate = ""; // 운동 면제권 날짜 (yyyyMMdd)

  // 기록페이지 걸음 수
  final Map<String, int> _stepHistory = {};

  // 아이템 정보
  final List<String> _myInventory = []; // 내가 가진 아이템 ID 리스트

  // 현재 장착 중인 아이템
  Map<String, String> _equippedItems = {
    'bowl': 'assets/images/main_images/food_normal_back.png', // 기본 밥그릇
    'water': 'assets/images/main_images/water_normal_back.png', // 기본 물통
    'wheel': 'assets/images/main_images/chat_normal_back.png', // 기본 챗바퀴
    'glass': '', // 선글라스
    'hair': '', // 머리핀
  };

  // 데이터 가져오기
  int get seedCount => _seedCount;
  int get todaySteps => _todaySteps;
  int get attendanceDays => _attendanceDays;
  String get nickname => _nickname;
  String get hamsterImage => _hamsterImage;
  String get currentHamsterState => _currentHamsterState; // 현재 햄스터 상태
  List<String> get myInventory => _myInventory;
  Map<String, String> get equippedItems => _equippedItems;
  Map<String, int> get stepHistory => _stepHistory;

  // 오늘이 운동 면제인지 확인하는 함수
  bool get isExemptToday {
    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    return _exemptionDate == today;
  }

  // 데이터 초기화 (죽음)
  Future<void> resetData() async {
    _nickname = "새로운 햄스터"; // 임시 이름
    _seedCount = 0; // 돈 초기화
    _todaySteps = 0;
    _attendanceDays = 1;

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
  }

  // 닉네임 설정
  void setNickname(String newName) {
    _nickname = newName;
    notifyListeners();
  }

  // 튜토리얼 완료 처리
  Future<void> completeTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    // 필요하면 여기서 추가 로직 수행
  }

  // 걸음 수 업데이트
  void updateSteps(int steps) {
    _todaySteps = steps;

    // 오늘 날짜 기록
    final String todayKey = DateFormat('yyyyMMdd').format(DateTime.now());
    _stepHistory[todayKey] = steps;

    notifyListeners(); // 화면 갱신 알림
  }

  // 아이템 구매
  bool buyItem(String itemId, int price) {
    if (_myInventory.contains(itemId)) return false; // 이미 있음
    if (_seedCount < price) return false; // 돈 부족

    _seedCount -= price; // 돈 깎기
    _myInventory.add(itemId); // 가방에 넣기
    notifyListeners();
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
  }

  // 소모품 사용 (염색, 닉네임 변경 등)
  void useConsumable(String itemId, String value) {
    // itemId에 따라 다른 동작
    if (itemId == 'item_dye') {
      _hamsterImage = value; // value에 이미지 경로 들어옴
    } else if (itemId == 'ticket_rename') {
      _nickname = value; // value에 새 이름 들어옴
    }
    // 소모품이니까 인벤토리에서 삭제하는 로직도 필요하면 추가
    notifyListeners();
  }

  // 도토리 획득
  void earnSeeds(int amount) {
    _seedCount += amount;
    notifyListeners();
  }

  // 닉네임 변경
  void changeNickname(String newName) {
    _nickname = newName;
    notifyListeners();
  }

  // 햄스터 스킨 변경
  void changeHamsterSkin(String newImagePath) {
    _hamsterImage = newImagePath;
    notifyListeners();
  }

  // 햄스터 상태 업데이트 (메인 페이지에서 호출)
  void updateHamsterState(String state) {
    _currentHamsterState = state;
    notifyListeners();
  }

  // 운동 면제권 사용
  void useExemptionTicket() {
    _exemptionDate = DateFormat('yyyyMMdd').format(DateTime.now());
    notifyListeners();
  }

  // 아이템 소모 (사용 시 인벤토리에서 삭제)
  void consumeItem(String itemId) {
    _myInventory.remove(itemId); // 인벤토리에서 삭제 → 상점에서 다시 구매 가능
    notifyListeners();
  }
}
