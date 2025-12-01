import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'inventory_screen_ui.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // 전체 아이템 데이터
  final List<Map<String, dynamic>> allItemsData = [
    {
      'id': 'food_normal',
      'name': '기본 밥그릇',
      'image': 'assets/images/inventory_images/food_normal_inventory.png',
      'preview':
          'assets/images/inventory_images/food_normal_inventory_preview.png',
      'category': 'bowl',
    },
    {
      'id': 'food_rare',
      'name': '고급 밥그릇',
      'image': 'assets/images/inventory_images/food_rare_inventory.png',
      'preview':
          'assets/images/inventory_images/food_rare_inventory_preview.png',
      'category': 'bowl',
    },
    {
      'id': 'food_epic',
      'name': '최고급 밥그릇',
      'image': 'assets/images/inventory_images/food_epic_inventory.png',
      'preview':
          'assets/images/inventory_images/food_epic_inventory_preview.png',
      'category': 'bowl',
    },

    // 물통
    {
      'id': 'watre_normal',
      'name': '기본 물통',
      'image': 'assets/images/inventory_images/water_normal_inventory.png',
      'preview':
          'assets/images/inventory_images/water_normal_inventory_preview.png',
      'category': 'water',
    },
    {
      'id': 'water_rare',
      'name': '고급 물통',
      'image': 'assets/images/inventory_images/water_rare_inventory.png',
      'preview':
          'assets/images/inventory_images/water_rare_inventory_preview.png',
      'category': 'water',
    },
    {
      'id': 'water_epic',
      'name': '최고급 물통',
      'image': 'assets/images/inventory_images/water_epic_inventory.png',
      'preview':
          'assets/images/inventory_images/water_epic_inventory_preview.png',
      'category': 'water',
    },

    // 챗바퀴
    {
      'id': 'chat_normal',
      'name': '기본 챗바퀴',
      'image': 'assets/images/inventory_images/chat_normal_inventory.png',
      'preview':
          'assets/images/inventory_images/chat_normal_inventory_preview.png',
      'category': 'wheel',
    },
    {
      'id': 'chat_rare',
      'name': '고급 챗바퀴',
      'image': 'assets/images/inventory_images/chat_rare_inventory.png',
      'preview':
          'assets/images/inventory_images/chat_rare_inventory_preview.png',
      'category': 'wheel',
    },
    {
      'id': 'chat_epic',
      'name': '최고급 챗바퀴',
      'image': 'assets/images/inventory_images/chat_epic_inventory.png',
      'preview':
          'assets/images/inventory_images/chat_epic_inventory_preview.png',
      'category': 'wheel',
    },

    // 액세서리
    {
      'id': 'sunglasses',
      'name': '썬글라스',
      'image': 'assets/images/inventory_images/sunglass_inventory.png',
      'preview':
          'assets/images/inventory_images/sunglass_inventory_preview.png',
      'category': 'glass',
    },
    {
      'id': 'hairpin',
      'name': '머리핀',
      'image': 'assets/images/inventory_images/hairpin_inventory.png',
      'preview': 'assets/images/inventory_images/hairpin_inventory_preview.png',
      'category': 'hair',
    },

    // 소모 아이템
    {
      'id': '1day',
      'name': '챗바퀴 타기(1일)',
      'image': '',
      'preview': 'assets/images/inventory_images/1day_inventory_preview.png',
      'category': 'consumable',
    },
    {
      'id': 'color_change',
      'name': '햄스터 염색권',
      'image': '',
      'preview':
          'assets/images/inventory_images/color_change_inventory_preview.png',
      'category': 'consumable',
    },
    {
      'id': 'nickname_change',
      'name': '이름 변경권',
      'image': '',
      'preview':
          'assets/images/inventory_images/nickname_change_inventory_preview.png',
      'category': 'consumable',
    },
  ];

  // 아이템 장착 함수
  void _equipItem(Map<String, dynamic> item) {
    final provider = context.read<UserProvider>(); // Provider 가져오기

    // 소모품 사용 로직
    if (item['category'] == 'consumable') {
      // 닉네임 변경권
      if (item['id'] == 'nickname_change') {
        _showNicknameDialog(provider, item['id']);
        return;
      }

      // 염색권
      if (item['id'] == 'color_change') {
        _showDyeDialog(provider, item['id']);
        return;
      }

      // 챗바퀴 1일권
      if (item['id'] == '1day') {
        provider.useExemptionTicket();
        provider.consumeItem(item['id']); // 사용 시 소모

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('오늘 하루 운동 면제')));
        return;
      }

      return;
    }

    // 치장 아이템 장착
    provider.equipItem(item['category'], item['image']);
  }

  // 닉네임 변경 팝업
  void _showNicknameDialog(UserProvider provider, String itemId) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("닉네임 변경"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "새 이름을 입력하세요"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                provider.changeNickname(textController.text);
                provider.consumeItem(itemId); // 사용 시 소모
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('이름이 변경되었습니다!')));
              }
            },
            child: const Text("변경"),
          ),
        ],
      ),
    );
  }

  // 염색 팝업 (임시)
  void _showDyeDialog(UserProvider provider, String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("햄스터 염색"),
        content: const Text("어떤 색으로 염색할까요? (예시 기능)"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              // provider.changeHamsterSkin('assets/.../ham_black.png');  // 염색 햄스터
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('염색 완료! (기능 준비중)')));
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final myInventoryIds = userProvider.myInventory;
    final equipped = userProvider.equippedItems;
    final myItems = allItemsData.where((item) {
      // 기본 아이템들은 항상 보이게
      if (item['id'].toString().contains('normal')) return true;
      // 내가 가진 아이템만 보이게
      return myInventoryIds.contains(item['id']);
    }).toList();

    // 카테고리 분류
    final equipItems = myItems
        .where((i) => i['category'] != 'consumable')
        .toList();
    final consumableItems = myItems
        .where((i) => i['category'] == 'consumable')
        .toList();

    // 현재 걸음 수에 따른 햄스터 상태 계산
    final int currentSteps = userProvider.todaySteps;
    final bool isExempt = userProvider.isExemptToday;
    String hamsterImagePath;
    
    if (isExempt || currentSteps >= 5000) {
      hamsterImagePath = 'assets/images/main_images/ham_1.png'; // 기본
    } else {
      hamsterImagePath = 'assets/images/main_images/ham_2.png'; // 살찜
    }

    return InventoryScreenUI(
      // Provider에 저장된 장착 이미지 경로 전달
      currentBowl: equipped['bowl'] ?? '',
      currentWater: equipped['water'] ?? '',
      currentWheel: equipped['wheel'] ?? '',
      currentGlass: equipped['glass'],
      currentHair: equipped['hair'],
      hamsterImagePath: hamsterImagePath, // 현재 햄스터 상태

      equipItems: equipItems,
      consumableItems: consumableItems,
      onEquipItem: _equipItem,
    );
  }
}
