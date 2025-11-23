import 'package:flutter/material.dart';
import 'store_screen_widgets.dart';

class StoreScreenUI extends StatelessWidget {
  final int mySeeds;
  final List<String> myInventory;
  final List<Map<String, dynamic>> storeItems;
  final Function(String, String, int) onBuyItem; // 구매 함수 전달받음

  const StoreScreenUI({
    super.key,
    required this.mySeeds,
    required this.myInventory,
    required this.storeItems,
    required this.onBuyItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '상점',
          style: TextStyle(
            color: Color(0xFF4D3817),
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
              // 상단 도토리
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/main_images/money_main_back.png',
                    width: 22,
                  ),
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

              // 카테고리별 섹션 구성
              _buildCategorySection("밥그릇", "bowl"),
              _buildCategorySection("챗바퀴", "wheel"),
              _buildCategorySection("썬글라스", "glass"),
              _buildCategorySection("머리핀", "hair"),
              _buildCategorySection("소모 아이템", "consumable"),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // 카테고리 섹션 빌더
  Widget _buildCategorySection(String title, String categoryCode) {
    final items = storeItems
        .where((item) => item['category'] == categoryCode)
        .toList();

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

        // 아이템 나열
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.65,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            final isOwned = myInventory.contains(item['id']);

            // 부품 호출
            return StoreItemCard(
              name: item['name'],
              price: item['price'],
              imagePath: item['image'],
              isOwned: isOwned,
              onTap: isOwned
                  ? null
                  : () => onBuyItem(item['id'], item['name'], item['price']),
            );
          },
        ),
      ],
    );
  }
}
