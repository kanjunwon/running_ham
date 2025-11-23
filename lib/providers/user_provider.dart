import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // 내 정보
  int _seedCount = 3000; // 도토리 (테스트용 3000개)
  int _todaySteps = 0; // 오늘 걸음 수
  String _nickname = "김햄찌"; // 닉네임
  String _hamsterImage =
      "assets/images/main_images/ham_1.png"; // 햄스터 본체 (기본 이미지)

  // 아이템 정보
  List<String> _myInventory = []; // 내가 가진 아이템 ID 리스트

  // 현재 장착 중인 아이템
  Map<String, String> _equippedItems = {
    'bowl': 'assets/images/main_images/food_normal_back.png', // 기본 밥그릇
    'water': 'assets/images/main_images/water_normal_back.png', // 기본 물통
    'wheel': 'assets/images/main_images/chat_normal_back.png', // 기본 챗바퀴
    'accsory': '', // 액세서리 없음
  };

  // 데이터 가져오기
  int get seedCount => _seedCount;
  int get todaySteps => _todaySteps; // 걸음 수 가져오기
  String get nickname => _nickname;
  String get hamsterImage => _hamsterImage;
  List<String> get myInventory => _myInventory;
  Map<String, String> get equippedItems => _equippedItems;

  // 걸음 수 업데이트
  void updateSteps(int steps) {
    _todaySteps = steps;
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
    if (category == 'acc' && _equippedItems['acc'] == imagePath) {
      _equippedItems['acc'] = '';
    } else {
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
}
