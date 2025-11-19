import 'package:flutter/material.dart';

// [1] 상품 목록 데이터 (카테고리별로 나중에 필터링함)
final List<Map<String, dynamic>> storeItems = [
  // --- 밥그릇 ---
  {
    'id': 'bowl_basic',
    'name': '기본 밥그릇',
    'price': 1000,
    'image': 'assets/images/main_images/item_bowl_basic.png',
    'category': 'bowl',
  },
  {
    'id': 'bowl_adv',
    'name': '고급 밥그릇',
    'price': 1500,
    'image': 'assets/images/main_images/item_bowl_adv.png',
    'category': 'bowl',
  },
  // --- 챗바퀴 ---
  {
    'id': 'wheel_basic',
    'name': '기본 챗바퀴',
    'price': 1000,
    'image': 'assets/images/main_images/item_wheel_basic.png',
    'category': 'wheel',
  },
  {
    'id': 'wheel_adv',
    'name': '고급 챗바퀴',
    'price': 1500,
    'image': 'assets/images/main_images/item_wheel_adv.png',
    'category': 'wheel',
  },
  // --- 액세서리 ---
  {
    'id': 'water_basic',
    'name': '기본 물통',
    'price': 1000,
    'image': 'assets/images/main_images/item_water_basic.png',
    'category': 'accessory',
  },
  {
    'id': 'water_adv',
    'name': '고급 물통',
    'price': 1500,
    'image': 'assets/images/main_images/item_water_adv.png',
    'category': 'accessory',
  },
  {
    'id': 'sunglasses',
    'name': '썬글라스',
    'price': 1000,
    'image': 'assets/images/main_images/item_sunglasses.png',
    'category': 'accessory',
  },
  {
    'id': 'hairpin',
    'name': '머리핀',
    'price': 1000,
    'image': 'assets/images/main_images/item_hairpin.png',
    'category': 'accessory',
  },
  // --- 소모 아이템 ---
  {
    'id': 'ticket_wheel',
    'name': '챗바퀴 타기(1일)',
    'price': 1500,
    'image': 'assets/images/main_images/item_ticket.png',
    'category': 'consumable',
  },
  {
    'id': 'item_dye',
    'name': '햄스터 염색권',
    'price': 1000,
    'image': 'assets/images/main_images/item_dye.png',
    'category': 'consumable',
  },
  {
    'id': 'ticket_name',
    'name': '이름변경권',
    'price': 1000,
    'image': 'assets/images/main_images/item_rename.png',
    'category': 'consumable',
  },
];

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // [테스트용 가짜 데이터]
  int mySeeds = 3000;
  List<String> myInventory = [];

  // 구매 로직 (UI 테스트용)
  void _buyItem(String itemId, String itemName, int price) {
    if (myInventory.contains(itemId)) return; // 이미 있으면 반응 X (또는 메시지)
    
    if (mySeeds < price) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도토리가 부족해요!')),
      );
      return;
    }

    setState(() {
      mySeeds -= price;
      myInventory.add(itemId);
    });

    // 심플한 토스트 메시지 느낌으로 성공 알림
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$itemName 구매 완료!'), duration: const Duration(milliseconds: 1000)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0), // 배경색 (베이지)
      
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '상점',
          style: TextStyle(
            color: Color(0xFF4D3817), // 갈색 텍스트
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFFF7F5F0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4D3817)),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 도토리 (우측 정렬)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/main_images/money_main_back.png', width: 22),
                  const SizedBox(width: 6),
                  Text(
                    '$mySeeds',
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AppleSDGothicNeoEB00',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // --- 카테고리별 섹션 ---
              _buildCategorySection("밥그릇", "bowl"),
              _buildCategorySection("챗바퀴", "wheel"),
              _buildCategorySection("액세서리", "accessory"),
              _buildCategorySection("소모 아이템", "consumable"),
              
              const SizedBox(height: 40), // 하단 여백
            ],
          ),
        ),
      ),
    );
  }

  // [카테고리 섹션 빌더]
  Widget _buildCategorySection(String title, String categoryCode) {
    // 해당 카테고리 아이템만 골라내기
    final items = storeItems.where((item) => item['category'] == categoryCode).toList();

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // 섹션 제목
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF4D3817),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        
        // 아이템 나열 (Wrap 사용 - 줄바꿈 자동)
        Wrap(
          spacing: 12, // 가로 간격
          runSpacing: 12, // 세로 간격
          children: items.map((item) {
            final isOwned = myInventory.contains(item['id']);
            return _buildItemCard(item, isOwned);
          }).toList(),
        ),
      ],
    );
  }

  // [아이템 카드 위젯]
  Widget _buildItemCard(Map<String, dynamic> item, bool isOwned) {
    // 화면 너비에 따라 카드 크기 계산 (대략 3등분 느낌)
    // final cardWidth = (MediaQuery.of(context).size.width - 64) / 3; 
    // Figma랑 비슷하게 고정 크기로 가는 게 나을 수도 있음
    const double cardWidth = 100; 
    const double cardHeight = 135;

    return GestureDetector(
      onTap: isOwned ? null : () => _buyItem(item['id'], item['name'], item['price']),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // 둥근 모서리
          // 그림자 살짝 (원하면 추가, 피그마는 거의 없어보임)
          // boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. 이미지
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Opacity(
                  opacity: isOwned ? 0.5 : 1.0, // 보유중이면 흐리게
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported, color: Colors.grey, size: 30),
                  ),
                ),
              ),
            ),
            
            // 2. 이름
            Text(
              item['name'],
              style: const TextStyle(
                color: Color(0xFF4D3817),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 6),

            // 3. 가격 (또는 보유중 표시)
            if (isOwned)
              const Text(
                "보유중",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/main_images/money_main_back.png', width: 14),
                  const SizedBox(width: 4),
                  Text(
                    "${item['price']}",
                    style: const TextStyle(
                      color: Color(0xFF4D3817),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            
            const SizedBox(height: 15), // 하단 여백
          ],
        ),
      ),
    );
  }
}