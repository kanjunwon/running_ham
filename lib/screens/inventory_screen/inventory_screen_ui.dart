import 'dart:math';
import 'package:flutter/material.dart';
import 'inventory_screen_widgets.dart';

class InventoryScreenUI extends StatelessWidget {
  // 현재 장착된 이미지 경로들
  final String currentBowl;
  final String currentWater;
  final String currentWheel;
  final String? currentGlass;
  final String? currentHair;
  final String hamsterImagePath; // 현재 햄스터 상태 이미지

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
    required this.hamsterImagePath,
    required this.equipItems,
    required this.consumableItems,
    required this.onEquipItem,
  });

  @override
  Widget build(BuildContext context) {
    // 화면 크기 기반 스케일링 로직 (너비 + 높이 모두 고려)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 피그마 기준 화면 크기 (iPhone 14 기준)
    const double baseWidth = 390.0;
    const double baseHeight = 844.0;

    // 너비와 높이 중 더 작은 비율 사용
    final double scaleWidth = screenWidth / baseWidth;
    final double scaleHeight = screenHeight / baseHeight;
    final double scale = min(scaleWidth, scaleHeight);

    // 비율 적용 헬퍼 함수
    double s(double value) => value * scale;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E6), // 배경색
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '보관함',
          style: TextStyle(
            color: const Color(0xFF4D3817),
            fontWeight: FontWeight.bold,
            fontSize: s(18), // 반응형 폰트
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
                  height: s(150),
                  child: Image.asset(
                    'assets/images/main_images/ground.png',
                    fit: BoxFit.cover, // 가로 꽉 채우기
                    cacheWidth:
                        (screenWidth * MediaQuery.of(context).devicePixelRatio)
                            .toInt(),
                  ),
                ),

                // 챗바퀴
                _buildPreviewWheel(currentWheel, scale),

                // 밥그릇
                _buildPreviewBowl(currentBowl, scale),

                // 물통
                _buildPreviewWater(currentWater, scale),

                // 햄스터 (중앙) - 현재 상태에 맞는 이미지
                Positioned(
                  bottom: s(50),
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      hamsterImagePath, // 현재 햄스터 상태
                      width: s(180),
                      cacheWidth: (s(180) * 2).toInt(),
                    ),
                  ),
                ),

                // 썬글라스
                if (currentGlass != null && currentGlass!.isNotEmpty)
                  _buildPreviewAccessory(
                    currentGlass!,
                    scale,
                    hamsterImagePath,
                  ),

                // 머리핀
                if (currentHair != null && currentHair!.isNotEmpty)
                  _buildPreviewAccessory(currentHair!, scale, hamsterImagePath),

                // 하단 그라데이션
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: s(60), // 그라데이션 높이
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
              padding: EdgeInsets.fromLTRB(s(20), s(20), s(20), 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(s(30)),
                  topRight: Radius.circular(s(30)),
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
                    _buildSectionTitle("치장 아이템", s),
                    _buildGrid(equipItems, s),

                    SizedBox(height: s(25)),

                    // 소모 아이템 섹션
                    _buildSectionTitle("소모 아이템", s),
                    _buildGrid(consumableItems, s),

                    SizedBox(height: s(30)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, double Function(double) s) {
    return Padding(
      padding: EdgeInsets.only(bottom: s(10)),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF4D3817),
          fontWeight: FontWeight.bold,
          fontSize: s(14),
        ),
      ),
    );
  }

  Widget _buildGrid(
    List<Map<String, dynamic>> items,
    double Function(double) s,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        crossAxisSpacing: s(10),
        mainAxisSpacing: s(10),
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

  // 보관함에서 미리 보는 치장 아이템 (햄스터 상태에 따라 위치 조정)
  Widget _buildPreviewAccessory(
    String imagePath,
    double scale,
    String hamsterPath,
  ) {
    double bottom = 0;
    double left = 0;
    double width = 100 * scale;

    // 햄스터 상태 확인
    final bool isNormal = hamsterPath.contains('ham_1');
    final bool isFat1 = hamsterPath.contains('ham_2');
    // ham_3 = fat2

    // 썬글라스 (normal / fat1 / fat2)
    if (imagePath.contains('sunglass')) {
      if (isNormal) {
        width = 100 * scale;
        bottom = 152 * scale;
        left = 0 * scale;
      } else if (isFat1) {
        width = 115 * scale;
        bottom = 145 * scale;
        left = 3 * scale;
      } else {
        // fat2
        width = 118 * scale;
        bottom = 148 * scale;
        left = 4 * scale;
      }

      // 머리핀 (normal / fat1 / fat2)
    } else if (imagePath.contains('hair')) {
      if (isNormal) {
        width = 55 * scale;
        bottom = 185 * scale;
        left = 72 * scale;
      } else if (isFat1) {
        width = 65 * scale;
        bottom = 178 * scale;
        left = 85 * scale;
      } else {
        // fat2
        width = 60 * scale;
        bottom = 177 * scale;
        left = 83 * scale;
      }
    } else {
      bottom = 100 * scale;
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
          child: Image.asset(
            imagePath,
            width: width,
            fit: BoxFit.contain,
            cacheWidth: (width * 2).toInt(),
          ),
        ),
      ),
    );
  }

  // 보관함 챗바퀴 위치 조절
  Widget _buildPreviewWheel(String imagePath, double scale) {
    double top = 20 * scale;
    double left = -40 * scale;
    double width = 220 * scale;
    double height = 220 * scale;

    if (imagePath.contains('rare')) {
      top = 18 * scale;
      left = -35 * scale;
    }

    // 최고급 - 바닥에 붙게
    if (imagePath.contains('epic')) {
      top = 25 * scale;
      left = -35 * scale;
    }

    return Positioned(
      top: top,
      left: left,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        cacheWidth: (width * 2).toInt(),
      ),
    );
  }

  // 보관함 밥그릇 위치 조절
  Widget _buildPreviewBowl(String imagePath, double scale) {
    double bottom = 35 * scale;
    double right = 15 * scale;
    double width = 130 * scale;
    double height = 75 * scale;

    if (imagePath.contains('rare')) {
      bottom = 32 * scale;
      right = 18 * scale;
      width = 135 * scale;
      height = 80 * scale;
    }

    if (imagePath.contains('epic')) {
      bottom = 30 * scale;
      right = 20 * scale;
      width = 140 * scale;
      height = 85 * scale;
    }

    return Positioned(
      bottom: bottom,
      right: right,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        cacheWidth: (width * 2).toInt(),
      ),
    );
  }

  // 보관함 물통 위치 조절
  Widget _buildPreviewWater(String imagePath, double scale) {
    double top = 15 * scale;
    double right = -25 * scale;
    double width = 110 * scale;
    double height = 220 * scale;

    if (imagePath.contains('rare')) {
      top = 12 * scale;
      right = -20 * scale;
    }

    // 최고급 - 크기 키우고 바닥에 붙게
    if (imagePath.contains('epic')) {
      width = 170 * scale;
      height = 280 * scale;
      top = 16 * scale;
      right = -52 * scale;
    }

    return Positioned(
      top: top,
      right: right,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        cacheWidth: (width * 2).toInt(),
      ),
    );
  }
}
