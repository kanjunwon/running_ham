import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 포맷팅

class UserProvider extends ChangeNotifier {
  // 내 정보
  int _seedCount = 300000; // 도토리 (테스트용 300000개)
  int _todaySteps = 0; // 오늘 걸음 수
  int _attendanceDays = 0; // 출석 일수

  String _nickname = "김햄찌"; // 닉네임
  String _hamsterImage =
      "assets/images/main_images/ham_1.png"; // 햄스터 본체 (기본 이미지)

  String _exemptionDate = ""; // 운동 면제권 날짜 (yyyyMMdd)

  // 기록페이지 걸음 수
  Map<String, int> _stepHistory = {
    // 테스트용 데이터
    '20251124': 8000,
    '20251125': 12000,
  };

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

  // 데이터 가져오기
  int get seedCount => _seedCount;
  int get todaySteps => _todaySteps;
  int get attendanceDays => _attendanceDays;
  String get nickname => _nickname;
  String get hamsterImage => _hamsterImage;
  List<String> get myInventory => _myInventory;
  Map<String, String> get equippedItems => _equippedItems;
  Map<String, int> get stepHistory => _stepHistory;

  // 오늘이 운동 면제인지 확인하는 함수
  bool get isExemptToday {
    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    return _exemptionDate == today;
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

  // 운동 면제권 사용
  void useExemptionTicket() {
    _exemptionDate = DateFormat('yyyyMMdd').format(DateTime.now());
    notifyListeners();
  }

  // 아이템 소모
  void consumeItem(String itemId) {
    // _myInventory.remove(itemId); // 테스트용이라 삭제 안할거임
    notifyListeners();
  }
}
