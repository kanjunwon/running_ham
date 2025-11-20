import 'package:flutter/material.dart';
import 'inventory_screen_ui.dart'; // UI 파일 import

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // 현재 장착된 이미지들
  String currentBowl = 'assets/images/main_images/food_normal_back.png';
  String currentWater = 'assets/images/main_images/water_normal_back.png';
  String currentWheel = 'assets/images/main_images/chat_normal_back.png';
  String? currentAccsory;

  // 내 아이템 목록
  final List<Map<String, dynamic>> myItems = [
    
    // --- 밥그릇 ---
    {
      'name': '기본 밥그릇',
      'image': 'assets/images/inventory_images/food_normal_inventory_image.png', // 장착용 큰 이미지
      'preview': 'assets/images/inventory_images/food_normal_inventory_preview.png', // 미리보기 작은 이미지
      'category': 'bowl',
    },
    {
      'name': '고급 밥그릇',
      'image': 'assets/images/inventory_images/food_rare_inventory_image.png',
      'preview': 'assets/images/inventory_images/food_rare_inventory_preview.png',
      'category': 'bowl',
    },
    // --- 물통 ---
    {
      'name': '기본 물통',
      'image': 'assets/images/inventory_images/water_normal_inventory_image.png',
      'preview': 'assets/images/inventory_images/water_normal_inventory_preview.png',
      'category': 'water',
    },
    {
      'name': '고급 물통',
      'image': 'assets/images/inventory_images/water_rare_inventory_image.png',
      'preview': 'assets/images/inventory_images/water_rare_inventory_preview.png',
      'category': 'water',
    },
    // --- 챗바퀴 ---
    {
      'name': '기본 챗바퀴',
      'image': 'assets/images/inventory_images/chat_normal_inventory_image.png',
      'preview': 'assets/images/inventory_images/chat_normal_inventory_preview.png',
      'category': 'wheel',
    },
    {
      'name': '고급 챗바퀴',
      'image': 'assets/images/inventory_images/chat_rare_inventory_image.png',
      'preview': 'assets/images/inventory_images/chat_rare_inventory_preview.png',
      'category': 'wheel',
    },
    // --- 액세서리 ---
    {
      'name': '썬글라스',
      'image': '', // 디자이너한테 주라고 하기
      'preview': 'assets/images/inventory_images/sunglass_inventory_preview.png',
      'category': 'accsory',
    },
    {
      'name': '머리핀',
      'image': 'assets/images/inventory_images/hairpin_inventory_image.png',
      'preview': 'assets/images/inventory_images/hairpin_inventory_preview.png',
      'category': 'accsory',
    },
    // --- 소모 아이템 ---
    {
      'name': '챗바퀴 타기(1일)',
      'image': '', 
      'preview': 'assets/images/inventory_images/1day_inventory_preview.png',
      'category': 'consumable',
    },
    {
      'name': '햄스터 염색권',
      'image': '', 
      'preview': 'assets/images/inventory_images/color_change_inventory_preview.png',
      'category': 'consumable',
    },
    {
      'name': '이름 변경권',
      'image': '', 
      'preview': 'assets/images/inventory_images/nickname_change_inventory_preview.png',
      'category': 'consumable',
    },
  ];

  // 아이템 장착 함수
  void _equipItem(Map<String, dynamic> item) {
    if (item['category'] == 'consumable') return;

    setState(() {
      // item (image)가 착용샷(큰 이미지) 역할
      switch (item['category']) {
        case 'bowl':
          currentBowl = item['image'];
          break;
        case 'water':
          currentWater = item['image'];
          break;
        case 'wheel':
          currentWheel = item['image'];
          break;
        case 'accsory':
          if (currentAccsory == item['image']) {
            currentAccsory = null;
          } else {
            currentAccsory = item['image'];
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 카테고리 분류
    final equipItems = myItems.where((i) => i['category'] != 'consumable').toList();
    final consumableItems = myItems.where((i) => i['category'] == 'consumable').toList();

    // UI 파일 호출
    return InventoryScreenUI(
      currentBowl: currentBowl,
      currentWater: currentWater,
      currentWheel: currentWheel,
      currentAccsory: currentAccsory,
      equipItems: equipItems,
      consumableItems: consumableItems,
      onEquipItem: _equipItem,
    );
  }
}