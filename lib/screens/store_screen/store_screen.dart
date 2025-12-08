import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'store_screen_ui.dart';

// 상품 목록
final List<Map<String, dynamic>> storeItemsData = [
  // 밥그릇
  {
    'id': 'food_rare',
    'name': '고급 밥그릇',
    'price': 1000,
    'image': 'assets/images/store_images/food_rare_store.png',
    'category': 'bowl',
  },
  {
    'id': 'food_epic',
    'name': '최고급 밥그릇',
    'price': 5000,
    'image': 'assets/images/store_images/food_epic_store.png',
    'category': 'bowl',
  },

  // 챗바퀴
  {
    'id': 'chat_rare',
    'name': '고급 챗바퀴',
    'price': 1000,
    'image': 'assets/images/store_images/chat_rare_store.png',
    'category': 'wheel',
  },
  {
    'id': 'chat_epic',
    'name': '최고급 챗바퀴',
    'price': 5000,
    'image': 'assets/images/store_images/chat_epic_store.png',
    'category': 'wheel',
  },

  // 물통
  {
    'id': 'water_rare',
    'name': '고급 물통',
    'price': 1000,
    'image': 'assets/images/store_images/water_rare_store.png',
    'category': 'water',
  },
  {
    'id': 'water_epic',
    'name': '최고급 물통',
    'price': 5000,
    'image': 'assets/images/store_images/water_epic_store.png',
    'category': 'water',
  },

  // 악세서리
  {
    'id': 'sunglasses',
    'name': '썬글라스',
    'price': 1000,
    'image': 'assets/images/store_images/sunglass_store.png',
    'category': 'glass',
  },
  {
    'id': 'hairpin',
    'name': '머리핀',
    'price': 1000,
    'image': 'assets/images/store_images/hairpin_store.png',
    'category': 'hair',
  },

  // 소모 아이템
  {
    'id': '1day',
    'name': '챗바퀴 타기(1일)',
    'price': 1500,
    'image': 'assets/images/store_images/1day_store.png',
    'category': 'consumable',
    'description':
        '챗바퀴 타기(1일)을 사용하면, 1일 동안 운동 면제가 적용되어, 5000보를 채우지 않아도 햄스터가 살찌지 않습니다.',
  },
  {
    'id': 'color_change',
    'name': '햄스터 염색권',
    'price': 1000,
    'image': 'assets/images/store_images/color_change_store.png',
    'category': 'consumable',
    'description': '파랑, 분홍, 검정, 기본의 색 중 랜덤한 색으로 햄스터의 색이 변경됩니다.',
  },
  {
    'id': 'nickname_change',
    'name': '이름변경권',
    'price': 1000,
    'image': 'assets/images/store_images/nickname_change_store.png',
    'category': 'consumable',
    'description': '햄스터의 이름을 다시 지어줄 수 있습니다. 단, 6글자가 넘어가는 이름은 지을 수 없습니다.',
  },
];

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // 구매 로직
  void _buyItem(String itemId, String itemName, int price) {
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

  // 소모 아이템 설명 다이얼로그
  void _showConsumableDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 상단 콘텐츠 (이미지 + 텍스트)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 아이템 이미지
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(item['image'], fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 16),
                    // 텍스트 영역
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 아이템 이름
                          Text(
                            item['name'],
                            style: const TextStyle(
                              color: Color(0xFF4D3817),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard',
                            ),
                          ),
                          const SizedBox(height: 8),
                          // 아이템 설명
                          Text(
                            item['description'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF4D3817),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // 하단 버튼들
                Row(
                  children: [
                    // 닫기 버튼
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB5B5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Center(
                            child: Text(
                              '닫기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 구매하기 버튼
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _buyItem(item['id'], item['name'], item['price']);
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE57373),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Center(
                            child: Text(
                              '구매하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return StoreScreenUI(
      mySeeds: userProvider.seedCount, // 도토리
      myInventory: userProvider.myInventory, // 보관함
      storeItems: storeItemsData,
      onBuyItem: _buyItem,
      onConsumableItemTap: _showConsumableDialog, // 소모 아이템 클릭 시
    );
  }
}
