import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // [1] 현재 장착된 이미지들 (상태 변수)
  // 초기값은 메인 화면과 동일하게 유지
  String currentBowl = 'assets/images/main_images/food_normal_back.png';
  String currentWater = 'assets/images/main_images/water_normal_back.png';
  String currentWheel = 'assets/images/main_images/chat_normal_back.png';
  String? currentAccsory;

  // [2] 내 아이템 목록 (경로 그대로 유지)
  final List<Map<String, dynamic>> myItems = [
    // --- 밥그릇 ---
    {
      'name': '기본 밥그릇',
      'image': 'assets/images/inventory_images/food_normal_inventory_image.png', // [장착용]
      'preview': 'assets/images/inventory_images/food_normal_inventory_preview.png', // [목록용]
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

  // [3] 아이템 장착 함수
  void _equipItem(Map<String, dynamic> item) {
    if (item['category'] == 'consumable') return;

    setState(() {
      // [수정됨] item['preview'] 대신 item['image']를 현재 장착 이미지로 설정!
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
    final equipItems = myItems.where((i) => i['category'] != 'consumable').toList();
    final consumableItems = myItems.where((i) => i['category'] == 'consumable').toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E6),
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
          // [1] 상단: 햄스터 방 미리보기
          Expanded(
            flex: 4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0, left: 0, right: 0, height: 150,
                  child: Image.asset('assets/images/main_images/ground.png', fit: BoxFit.fill),
                ),
                Positioned(
                  top: 20, left: -40,
                  child: Image.asset(currentWheel, width: 220, height: 220),
                ),
                Positioned(
                  bottom: 30, right: 10,
                  child: Image.asset(currentBowl, width: 110, height: 60),
                ),
                Positioned(
                  top: 20, right: -30,
                  child: Image.asset(currentWater, width: 100, height: 200),
                ),
                Positioned(
                  bottom: 50, left: 0, right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/images/main_images/ham_1.png', width: 180),
                  ),
                ),
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

          // [2] 하단: 아이템 목록
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
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("치장 아이템", 
                        style: TextStyle(color: Color(0xFF4D3817), fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),
                    
                    _buildGrid(equipItems),

                    const SizedBox(height: 25),

                    const Text("소모 아이템", 
                        style: TextStyle(color: Color(0xFF4D3817), fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),

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
        
        // [수정됨] 장착 확인 로직: item['preview']가 아니라 item['image']와 비교
        bool isEquipped = false;
        if (item['category'] != 'consumable') {
           isEquipped = 
             currentBowl == item['image'] || 
             currentWater == item['image'] || 
             currentWheel == item['image'] || 
             currentAccsory == item['image'];
        }

        return GestureDetector(
          onTap: () => _equipItem(item),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isEquipped ? const Color(0xFFE76F6F) : Colors.grey.shade200,
                    width: isEquipped ? 2 : 1,
                  ),
                  boxShadow: [
                    if (isEquipped)
                      BoxShadow(color: const Color(0xFFE76F6F).withOpacity(0.2), blurRadius: 4)
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  // [수정됨] 목록(Grid)에는 item['preview']를 보여줌!
                  child: Image.asset(
                    item['preview'],
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => const Icon(Icons.help_outline, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item['name'],
                style: const TextStyle(fontSize: 11, color: Color(0xFF4D3817)),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}