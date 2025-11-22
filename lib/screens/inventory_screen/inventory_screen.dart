import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ★ Provider 추가
import 'package:running_ham/providers/user_provider.dart'; // ★ 뇌(Provider) 가져오기
import 'inventory_screen_ui.dart'; // UI 파일 import

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // [2] 전체 아이템 데이터 (경로는 그대로 둠)
  final List<Map<String, dynamic>> allItemsData = [
    // ... (아까 호미가 작성한 긴 리스트 그대로!) ...
    // --- 밥그릇 ---
    {
      'id': 'bowl_basic', // ★ id 추가됨 (상점이랑 맞춰야 함!)
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
    // --- 물통 ---
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
    // --- 챗바퀴 ---
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
    // --- 액세서리 ---
    {
      'id': 'sunglasses',
      'name': '썬글라스',
      'image': '',
      'preview':
          'assets/images/inventory_images/sunglass_inventory_preview.png',
      'category': 'accsory', // accsory로 통일
    },
    {
      'id': 'hairpin',
      'name': '머리핀',
      'image': 'assets/images/inventory_images/hairpin_inventory_image.png',
      'preview': 'assets/images/inventory_images/hairpin_inventory_preview.png',
      'category': 'accsory',
    },
    // --- 소모 아이템 ---
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

  // [3] 아이템 장착 함수 (Provider 사용)
  void _equipItem(Map<String, dynamic> item) {
    if (item['category'] == 'consumable') {
      // 소모품 사용 로직 (나중에 구현)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${item['name']} 사용!')));
      return;
    }

    // ★ 뇌(Provider)한테 "이거 입혀줘!" 명령
    // item['image']가 큰 이미지(착용샷) 경로임
    context.read<UserProvider>().equipItem(item['category'], item['image']);
  }

  @override
  Widget build(BuildContext context) {
    // ★ 뇌(Provider) 감시: 내 가방이랑 장착 상태가 바뀌면 화면 다시 그림
    final userProvider = context.watch<UserProvider>();
    final myInventoryIds = userProvider.myInventory;
    final equipped = userProvider.equippedItems;

    // [필터링] 전체 아이템 중에서 '내가 가진 것(ID)'만 골라냄
    // (단, 기본 아이템들은 없어도 보이게 하려면 로직 추가 필요. 일단은 가진 것만!)
    final myItems = allItemsData.where((item) {
      // 기본 아이템들은 항상 보이게 (id에 basic이 들어간 것들)
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
      currentAccsory: equipped['accsory'], // key 이름 주의 (acc vs accsory)

      equipItems: equipItems,
      consumableItems: consumableItems,
      onEquipItem: _equipItem,
    );
  }
}
