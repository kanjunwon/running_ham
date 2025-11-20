import 'package:flutter/material.dart';
import 'inventory_screen_widgets.dart'; // 부품 import

class InventoryScreenUI extends StatelessWidget {
  // 현재 장착된 이미지 경로들
  final String currentBowl;
  final String currentWater;
  final String currentWheel;
  final String? currentAccsory;
  
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
    required this.currentAccsory,
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
          style: TextStyle(color: Color(0xFF4D3817), fontWeight: FontWeight.bold),
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
                // 배경
                Positioned(
                  bottom: 0, left: 0, right: 0, height: 150,
                  child: Image.asset('assets/images/main_images/ground.png', fit: BoxFit.fill),
                ),
                // 챗바퀴
                Positioned(
                  top: 20, left: -40,
                  child: Image.asset(currentWheel, width: 220, height: 220),
                ),
                // 밥그릇
                Positioned(
                  bottom: 30, right: 10,
                  child: Image.asset(currentBowl, width: 110, height: 60),
                ),
                // 물통
                Positioned(
                  top: 20, right: -30,
                  child: Image.asset(currentWater, width: 100, height: 200),
                ),
                // 햄스터
                Positioned(
                  bottom: 50, left: 0, right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/images/main_images/ham_1.png', width: 180),
                  ),
                ),
                // 액세서리 (있으면 보여줌)
                if (currentAccsory != null)
                  Positioned(
                    bottom: 150, left: 0, right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(currentAccsory!, width: 80),
                    ),
                  ),
              ],
            ),
          ),

          // 아이템 목록
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5)),
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
        crossAxisCount: 4, // 한 줄에 4개
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
             currentAccsory == item['image'];
        }

        // 부품 호출
        return InventoryItemCard(
          name: item['name'],
          // 목록에는 preview (작은 아이콘) 보여주기
          imagePath: item['preview'], 
          isEquipped: isEquipped,
          onTap: () => onEquipItem(item),
        );
      },
    );
  }
}