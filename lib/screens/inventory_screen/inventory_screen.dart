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
      'id': 'bowl_basic',
      'name': '기본 밥그릇',
      'image': 'assets/images/inventory_images/food_normal_inventory_image.png',
      'preview':
          'assets/images/inventory_images/food_normal_inventory_preview.png',
      'category': 'bowl',
    },
    {
      'id': 'bowl_adv',
      'name': '고급 밥그릇',
      'image': 'assets/images/inventory_images/food_rare_inventory_image.png',
      'preview':
          'assets/images/inventory_images/food_rare_inventory_preview.png',
      'category': 'bowl',
    },

    // 물통
    {
      'id': 'water_basic',
      'name': '기본 물통',
      'image':
          'assets/images/inventory_images/water_normal_inventory_image.png',
      'preview':
          'assets/images/inventory_images/water_normal_inventory_preview.png',
      'category': 'water',
    },
    {
      'id': 'water_adv',
      'name': '고급 물통',
      'image': 'assets/images/inventory_images/water_rare_inventory_image.png',
      'preview':
          'assets/images/inventory_images/water_rare_inventory_preview.png',
      'category': 'water',
    },

    // 챗바퀴
    {
      'id': 'wheel_basic',
      'name': '기본 챗바퀴',
      'image': 'assets/images/inventory_images/chat_normal_inventory_image.png',
      'preview':
          'assets/images/inventory_images/chat_normal_inventory_preview.png',
      'category': 'wheel',
    },
    {
      'id': 'wheel_adv',
      'name': '고급 챗바퀴',
      'image': 'assets/images/inventory_images/chat_rare_inventory_image.png',
      'preview':
          'assets/images/inventory_images/chat_rare_inventory_preview.png',
      'category': 'wheel',
    },

    // 액세서리
    {
      'id': 'sunglasses',
      'name': '썬글라스',
      'image': 'assets/images/inventory_images/sunglass_inventory_image.png',
      'preview':
          'assets/images/inventory_images/sunglass_inventory_preview.png',
      'category': 'glass',
    },
    {
      'id': 'hairpin',
      'name': '머리핀',
      'image': 'assets/images/inventory_images/hairpin_inventory_image.png',
      'preview': 'assets/images/inventory_images/hairpin_inventory_preview.png',
      'category': 'hair',
    },

    // 소모 아이템
    {
      'id': 'ticket_wheel',
      'name': '챗바퀴 타기(1일)',
      'image': '',
      'preview': 'assets/images/inventory_images/1day_inventory_preview.png',
      'category': 'consumable',
    },
    {
      'id': 'item_dye',
      'name': '햄스터 염색권',
      'image': '',
      'preview':
          'assets/images/inventory_images/color_change_inventory_preview.png',
      'category': 'consumable',
    },
    {
      'id': 'ticket_name',
      'name': '이름 변경권',
      'image': '',
      'preview':
          'assets/images/inventory_images/nickname_change_inventory_preview.png',
      'category': 'consumable',
    },
  ];

  // 아이템 장착 함수
  void _equipItem(Map<String, dynamic> item) {
    if (item['category'] == 'consumable') {
      // 소모품 사용 로직
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${item['name']} 사용!')));
      return;
    }

    context.read<UserProvider>().equipItem(item['category'], item['image']);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final myInventoryIds = userProvider.myInventory;
    final equipped = userProvider.equippedItems;
    final myItems = allItemsData.where((item) {
      // 기본 아이템들은 항상 보이게
      if (item['id'].toString().contains('basic')) return true;
      return myInventoryIds.contains(item['id']);
    }).toList();

    // 카테고리 분류
    final equipItems = myItems
        .where((i) => i['category'] != 'consumable')
        .toList();
    final consumableItems = myItems
        .where((i) => i['category'] == 'consumable')
        .toList();

    return InventoryScreenUI(
      // Provider에 저장된 장착 이미지 경로 전달
      currentBowl: equipped['bowl'] ?? '',
      currentWater: equipped['water'] ?? '',
      currentWheel: equipped['wheel'] ?? '',
      currentGlass: equipped['glass'],
      currentHair: equipped['hair'],

      equipItems: equipItems,
      consumableItems: consumableItems,
      onEquipItem: _equipItem,
    );
  }
}
