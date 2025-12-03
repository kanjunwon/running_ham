import 'dart:math';
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
    // 화면 크기 기반 스케일링 (너비 + 높이 모두 고려)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const double baseWidth = 390.0;
    const double baseHeight = 844.0;
    final double scale = min(
      screenWidth / baseWidth,
      screenHeight / baseHeight,
    );

    // 비율 적용 헬퍼 함수
    double s(double value) => value * scale;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6), // 배경색
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '상점',
          style: TextStyle(
            color: const Color(0xFF4D3817),
            fontWeight: FontWeight.bold,
            fontSize: s(18), // 폰트 크기 반응형
          ),
        ),
        backgroundColor: const Color(0xFFFFF6F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4D3817)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(20.0)), // 좌우 여백 반응형
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 도토리
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/main_images/money_main_back.png',
                    width: s(22), // 아이콘 크기 반응형
                  ),
                  SizedBox(width: s(6)),
                  Text(
                    '$mySeeds',
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: s(16),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ],
              ),
              SizedBox(height: s(10)),

              // 카테고리별 섹션 구성
              _buildCategorySection("밥그릇", "bowl", s),
              _buildCategorySection("챗바퀴", "wheel", s),
              _buildCategorySection("물통", "water", s),
              _buildCategorySection("썬글라스", "glass", s),
              _buildCategorySection("머리핀", "hair", s),
              _buildCategorySection("소모 아이템", "consumable", s),

              SizedBox(height: s(40)),
            ],
          ),
        ),
      ),
    );
  }

  // 카테고리 섹션 빌더 (s 함수를 인자로 받아서 내부 크기 조절)
  Widget _buildCategorySection(
    String title,
    String categoryCode,
    double Function(double) s,
  ) {
    final items = storeItems
        .where((item) => item['category'] == categoryCode)
        .toList();

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: s(20)),
        // 섹션 제목
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF4D3817),
            fontSize: s(14),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: s(10)),

        // 아이템 나열
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.65, // 비율은 고정
            crossAxisSpacing: s(15), // 간격 반응형
            mainAxisSpacing: s(20), // 간격 반응형
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
