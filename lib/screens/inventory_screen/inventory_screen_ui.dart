import 'package:flutter/material.dart';
import 'inventory_screen_widgets.dart';

class InventoryScreenUI extends StatelessWidget {
  // 현재 장착된 이미지 경로들
  final String currentBowl;
  final String currentWater;
  final String currentWheel;
  final String? currentGlass;
  final String? currentHair;

  // 아이템 리스트
  final List<Map<String, dynamic>> equipItems;
  final List<Map<String, dynamic>> consumableItems;

  // 장착 함수
  final Function(Map<String, dynamic>) onEquipItem;

  const InventoryScreenUI({
    super.key,
    required this.currentBowl,
    required this.currentWater,
    required this.currentWheel,
    required this.currentGlass,
    required this.currentHair,
    required this.equipItems,
    required this.consumableItems,
    required this.onEquipItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E6), // 배경색
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '보관함',
          style: TextStyle(
            color: Color(0xFF4D3817),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4D3817)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 햄스터 방 미리보기
          Expanded(
            flex: 4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 배경 (톳밥)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 150,
                  child: Image.asset(
                    'assets/images/main_images/ground.png',
                    fit: BoxFit.cover, // 가로 꽉 채우기
                  ),
                ),

                // 챗바퀴
                Positioned(
                  top: 20,
                  left: -40,
                  child: Image.asset(currentWheel, width: 220, height: 220),
                ),

                // 밥그릇
                Positioned(
                  bottom: 30,
                  right: 10,
                  child: Image.asset(currentBowl, width: 110, height: 60),
                ),

                // 물통
                Positioned(
                  top: 20,
                  right: -30,
                  child: Image.asset(currentWater, width: 100, height: 200),
                ),

                // 햄스터 (중앙)
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/main_images/ham_1.png',
                      width: 180,
                    ),
                  ),
                ),

                // 썬글라스
                if (currentGlass != null && currentGlass!.isNotEmpty)
                  _buildPreviewAccessory(currentGlass!),

                // 머리핀
                if (currentHair != null && currentHair!.isNotEmpty)
                  _buildPreviewAccessory(currentHair!),

                // 하단 그라데이션
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60, // 그라데이션 높이
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.0), // 위쪽: 완전 투명
                          Colors.white, // 아래쪽: 완전 흰색
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 아이템 목록
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                // 상단 그림자
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // 아주 연한 그림자
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(0, -5), // 위쪽으로 그림자 지게 함
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 치장 아이템 섹션
                    _buildSectionTitle("치장 아이템"),
                    _buildGrid(equipItems),

                    const SizedBox(height: 25),

                    // 소모 아이템 섹션
                    _buildSectionTitle("소모 아이템"),
                    _buildGrid(consumableItems),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF4D3817),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        // 장착 중인지 확인
        bool isEquipped = false;
        if (item['category'] != 'consumable') {
          isEquipped =
              currentBowl == item['image'] ||
              currentWater == item['image'] ||
              currentWheel == item['image'] ||
              currentGlass == item['image'] ||
              currentHair == item['image'];
        }

        return InventoryItemCard(
          name: item['name'],
          imagePath: item['preview'],
          isEquipped: isEquipped,
          onTap: () => onEquipItem(item),
        );
      },
    );
  }
}

// 보관함에서 미리 보는 치장 아이템
Widget _buildPreviewAccessory(String imagePath) {
  double bottom = 0;
  double left = 0;
  double width = 100;

  // 썬글라스
  if (imagePath.contains('sunglass')) {
    width = 120;
    bottom = 166;
    left = 3;

    // 머리핀
  } else if (imagePath.contains('hair')) {
    width = 70;
    bottom = 190;
    left = 83;
  } else {
    bottom = 100;
    left = 0;
  }

  return Positioned(
    bottom: bottom,
    left: 0,
    right: 0,
    child: Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(left: left),
        child: Image.asset(imagePath, width: width, fit: BoxFit.contain),
      ),
    ),
  );
}
