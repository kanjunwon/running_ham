import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ★ Provider 추가
import 'package:running_ham/providers/user_provider.dart'; // ★ 뇌(Provider) 가져오기
import 'store_screen_ui.dart'; // UI 파일 import

// [데이터] 상품 목록 (그대로 유지)
final List<Map<String, dynamic>> storeItemsData = [
  // --- 밥그릇 ---
  {
    'id': 'bowl_basic',
    'name': '기본 밥그릇',
    'price': 1000,
    'image': 'assets/images/store_images/food_normal_store.png',
    'category': 'bowl',
  },
  {
    'id': 'bowl_adv',
    'name': '고급 밥그릇',
    'price': 1500,
    'image': 'assets/images/store_images/food_rare_store.png',
    'category': 'bowl',
  },
  // --- 챗바퀴 ---
  {
    'id': 'wheel_basic',
    'name': '기본 챗바퀴',
    'price': 1000,
    'image': 'assets/images/store_images/chat_normal_store.png',
    'category': 'wheel',
  },
  {
    'id': 'wheel_adv',
    'name': '고급 챗바퀴',
    'price': 1500,
    'image': 'assets/images/store_images/chat_rare_store.png',
    'category': 'wheel',
  },
  // --- 액세서리 ---
  {
    'id': 'water_basic',
    'name': '기본 물통',
    'price': 1000,
    'image': 'assets/images/store_images/water_normal_store.png',
    'category': 'accessory',
  },
  {
    'id': 'water_adv',
    'name': '고급 물통',
    'price': 1500,
    'image': 'assets/images/store_images/water_rare_store.png',
    'category': 'accessory',
  },
  {
    'id': 'sunglasses',
    'name': '썬글라스',
    'price': 1000,
    'image': 'assets/images/store_images/sunglass_store.png',
    'category': 'accessory',
  },
  {
    'id': 'hairpin',
    'name': '머리핀',
    'price': 1000,
    'image': 'assets/images/store_images/hairpin_store.png',
    'category': 'accessory',
  },
  // --- 소모 아이템 ---
  {
    'id': 'ticket_wheel',
    'name': '챗바퀴 타기(1일)',
    'price': 1500,
    'image': 'assets/images/store_images/1day_store.png',
    'category': 'consumable',
  },
  {
    'id': 'item_dye',
    'name': '햄스터 염색권',
    'price': 1000,
    'image': 'assets/images/store_images/color_change_store.png',
    'category': 'consumable',
  },
  {
    'id': 'ticket_name',
    'name': '이름변경권',
    'price': 1000,
    'image': 'assets/images/store_images/nickname_change_store.png',
    'category': 'consumable',
  },
];

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // [진짜] 구매 로직 (Provider 사용)
  void _buyItem(String itemId, String itemName, int price) {
    // ★ 뇌(Provider)한테 구매 요청! (성공 여부를 true/false로 받음)
    bool isSuccess = context.read<UserProvider>().buyItem(itemId, price);

    if (isSuccess) {
      // 성공 시 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$itemName 구매 완료!'),
          duration: const Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      // 실패 시 (돈 부족)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('도토리가 부족해요!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // ★ 뇌(Provider)를 감시해서 내 돈이나 가방이 바뀌면 화면 다시 그림
    final userProvider = context.watch<UserProvider>();

    return StoreScreenUI(
      mySeeds: userProvider.seedCount, // 진짜 도토리
      myInventory: userProvider.myInventory, // 진짜 가방
      storeItems: storeItemsData,
      onBuyItem: _buyItem,
    );
  }
}
