import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // [1] 현재 장착된 이미지들 (상태 변수)
  String currentBowl = 'assets/images/main_images/food_normal_back.png';
  String currentWater = 'assets/images/main_images/water_normal_back.png';
  String currentWheel = 'assets/images/main_images/chat_normal_back.png';
  String? currentAcc;

  // [2] 내 아이템 목록 (테스트용 데이터)
  final List<Map<String, dynamic>> myItems = [
    // --- 밥그릇 ---
    {
      'name': '기본 밥그릇',
      'image': 'assets/images/main_images/item_bowl_basic.png',
      'preview': 'assets/images/main_images/food_normal_back.png',
      'category': 'bowl',
    },
    {
      'name': '고급 밥그릇',
      'image': 'assets/images/main_images/item_bowl_adv.png',
      'preview': 'assets/images/main_images/food_gold_back.png',
      'category': 'bowl',
    },
    // --- 물통 ---
    {
      'name': '기본 물통',
      'image': 'assets/images/main_images/item_water_basic.png',
      'preview': 'assets/images/main_images/water_normal_back.png',
      'category': 'water',
    },
    {
      'name': '고급 물통',
      'image': 'assets/images/main_images/item_water_adv.png',
      'preview': 'assets/images/main_images/water_pink_back.png',
      'category': 'water',
    },
    // --- 챗바퀴 ---
    {
      'name': '기본 챗바퀴',
      'image': 'assets/images/main_images/item_wheel_basic.png',
      'preview': 'assets/images/main_images/chat_normal_back.png',
      'category': 'wheel',
    },
    {
      'name': '고급 챗바퀴',
      'image': 'assets/images/main_images/item_wheel_adv.png',
      'preview': 'assets/images/main_images/chat_blue_back.png',
      'category': 'wheel',
    },
    // --- 액세서리 ---
    {
      'name': '썬글라스',
      'image': 'assets/images/main_images/item_sunglasses.png',
      'preview': 'assets/images/main_images/acc_sunglasses.png',
      'category': 'acc',
    },
    {
      'name': '머리핀',
      'image': 'assets/images/main_images/item_hairpin.png',
      'preview': 'assets/images/main_images/acc_hairpin.png',
      'category': 'acc',
    },
    // --- 소모 아이템 (카테고리: consumable) ---
    {
      'name': '챗바퀴 타기(1일)',
      'image': 'assets/images/main_images/item_ticket.png',
      'preview': '', // 소모품은 미리보기 없음
      'category': 'consumable',
    },
    {
      'name': '햄스터 염색권',
      'image': 'assets/images/main_images/item_dye.png',
      'preview': '',
      'category': 'consumable',
    },
    {
      'name': '이름 변경권',
      'image': 'assets/images/main_images/item_rename.png',
      'preview': '',
      'category': 'consumable',
    },
  ];

  // [3] 아이템 장착 함수
  void _equipItem(Map<String, dynamic> item) {
    // 소모품이면 장착 X
    if (item['category'] == 'consumable') return;

    setState(() {
      switch (item['category']) {
        case 'bowl':
          currentBowl = item['preview'];
          break;
        case 'water':
          currentWater = item['preview'];
          break;
        case 'wheel':
          currentWheel = item['preview'];
          break;
        case 'acc':
          if (currentAcc == item['preview']) {
            currentAcc = null;
          } else {
            currentAcc = item['preview'];
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 리스트를 두 개로 쪼개기! (치장용 vs 소모품용)
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
                if (currentAcc != null)
                  Positioned(
                    bottom: 150, left: 0, right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(currentAcc!, width: 80),
                    ),
                  ),
              ],
            ),
          ),

          // [2] 하단: 아이템 목록 (흰색 카드)
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
              
              // [수정됨] GridView 하나가 아니라, ListView 안에 섹션을 나눔
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. 치장 아이템 섹션
                    const Text("치장 아이템", 
                        style: TextStyle(color: Color(0xFF4D3817), fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),
                    
                    _buildGrid(equipItems), // 치장 아이템 그리드

                    const SizedBox(height: 25), // 섹션 사이 간격

                    // 2. 소모 아이템 섹션 (여기가 호미가 원하던 위치!)
                    const Text("소모 아이템", 
                        style: TextStyle(color: Color(0xFF4D3817), fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 10),

                    _buildGrid(consumableItems), // 소모 아이템 그리드
                    
                    const SizedBox(height: 30), // 맨 밑 여백
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 그리드 만드는 함수 (중복 제거용)
  Widget _buildGrid(List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true, // [중요] Column 안에서 크기만큼만 차지하게 함
      physics: const NeverScrollableScrollPhysics(), // 스크롤은 부모(SingleChildScrollView)한테 맡김
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        
        // 장착 여부 확인 (테두리용) - 소모품은 제외
        bool isEquipped = false;
        if (item['category'] != 'consumable') {
           isEquipped = 
             currentBowl == item['preview'] || 
             currentWater == item['preview'] || 
             currentWheel == item['preview'] || 
             currentAcc == item['preview'];
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
                  child: Image.asset(
                    item['image'],
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