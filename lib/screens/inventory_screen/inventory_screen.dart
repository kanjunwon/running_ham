import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'inventory_screen_ui.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // 전체 아이템 데이터
  final List<Map<String, dynamic>> allItemsData = [
    {
      'id': 'food_normal',
      'name': '기본 밥그릇',
      'image': 'assets/images/inventory_images/food_normal_inventory.png',
      'preview':
          'assets/images/inventory_images/food_normal_inventory_preview.png',
      'category': 'bowl',
    },
    {
      'id': 'food_rare',
      'name': '고급 밥그릇',
      'image': 'assets/images/inventory_images/food_rare_inventory.png',
      'preview':
          'assets/images/inventory_images/food_rare_inventory_preview.png',
      'category': 'bowl',
    },
    {
      'id': 'food_epic',
      'name': '최고급 밥그릇',
      'image': 'assets/images/inventory_images/food_epic_inventory.png',
      'preview':
          'assets/images/inventory_images/food_epic_inventory_preview.png',
      'category': 'bowl',
    },

    // 물통
    {
      'id': 'water_normal',
      'name': '기본 물통',
      'image': 'assets/images/inventory_images/water_normal_inventory.png',
      'preview':
          'assets/images/inventory_images/water_normal_inventory_preview.png',
      'category': 'water',
    },
    {
      'id': 'water_rare',
      'name': '고급 물통',
      'image': 'assets/images/inventory_images/water_rare_inventory.png',
      'preview':
          'assets/images/inventory_images/water_rare_inventory_preview.png',
      'category': 'water',
    },
    {
      'id': 'water_epic',
      'name': '최고급 물통',
      'image': 'assets/images/inventory_images/water_epic_inventory.png',
      'preview':
          'assets/images/inventory_images/water_epic_inventory_preview.png',
      'category': 'water',
    },

    // 챗바퀴
    {
      'id': 'chat_normal',
      'name': '기본 챗바퀴',
      'image': 'assets/images/inventory_images/chat_normal_inventory.png',
      'preview':
          'assets/images/inventory_images/chat_normal_inventory_preview.png',
      'category': 'wheel',
    },
    {
      'id': 'chat_rare',
      'name': '고급 챗바퀴',
      'image': 'assets/images/inventory_images/chat_rare_inventory.png',
      'preview':
          'assets/images/inventory_images/chat_rare_inventory_preview.png',
      'category': 'wheel',
    },
    {
      'id': 'chat_epic',
      'name': '최고급 챗바퀴',
      'image': 'assets/images/inventory_images/chat_epic_inventory.png',
      'preview':
          'assets/images/inventory_images/chat_epic_inventory_preview.png',
      'category': 'wheel',
    },

    // 액세서리
    {
      'id': 'sunglasses',
      'name': '썬글라스',
      'image': 'assets/images/inventory_images/sunglass_inventory.png',
      'preview':
          'assets/images/inventory_images/sunglass_inventory_preview.png',
      'category': 'glass',
    },
    {
      'id': 'hairpin',
      'name': '머리핀',
      'image': 'assets/images/inventory_images/hairpin_inventory.png',
      'preview': 'assets/images/inventory_images/hairpin_inventory_preview.png',
      'category': 'hair',
    },

    // 소모 아이템
    {
      'id': '1day',
      'name': '챗바퀴 타기(1일)',
      'image': '',
      'preview': 'assets/images/inventory_images/1day_inventory_preview.png',
      'category': 'consumable',
      'description':
          '챗바퀴 타기(1일)을 사용하면, 1일 동안 운동 면제가 적용되어, 5000보를 채우지 않아도 햄스터가 살찌지 않습니다.',
    },
    {
      'id': 'color_change',
      'name': '햄스터 염색권',
      'image': '',
      'preview':
          'assets/images/inventory_images/color_change_inventory_preview.png',
      'category': 'consumable',
      'description': '파랑, 분홍, 검정, 기본의 색 중 랜덤한 색으로 햄스터의 색이 변경됩니다.',
    },
    {
      'id': 'nickname_change',
      'name': '이름 변경권',
      'image': '',
      'preview':
          'assets/images/inventory_images/nickname_change_inventory_preview.png',
      'category': 'consumable',
      'description': '햄스터의 이름을 다시 지어줄 수 있습니다. 단, 6글자가 넘어가는 이름은 지을 수 없습니다.',
    },
  ];

  // 아이템 장착 함수
  void _equipItem(Map<String, dynamic> item) {
    final provider = context.read<UserProvider>(); // Provider 가져오기

    // 소모품 사용 로직 - 먼저 설명 다이얼로그 표시
    if (item['category'] == 'consumable') {
      _showConsumableDialog(item);
      return;
    }

    // 치장 아이템 장착
    provider.equipItem(item['category'], item['image']);
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
                      child: Image.asset(item['preview'], fit: BoxFit.contain),
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
                    // 사용하기 버튼
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _useConsumableItem(item);
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE57373),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Center(
                            child: Text(
                              '사용하기',
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

  // 소모 아이템 실제 사용 로직
  void _useConsumableItem(Map<String, dynamic> item) {
    final provider = context.read<UserProvider>();

    // 닉네임 변경권
    if (item['id'] == 'nickname_change') {
      _showNicknameDialog(provider, item['id']);
      return;
    }

    // 염색권 - 바로 염색 실행
    if (item['id'] == 'color_change') {
      // 가능한 색상 리스트 (현재 색상 제외)
      final allColors = ['default', 'black', 'pink', 'sky'];
      final currentColor = provider.hamsterColor;
      final availableColors = allColors
          .where((c) => c != currentColor)
          .toList();

      // 랜덤 색상 선택
      final random = Random();
      final newColor = availableColors[random.nextInt(availableColors.length)];

      provider.changeHamsterColor(newColor);
      provider.consumeItem(item['id']); // 사용 시 소모

      // 색상 이름 한글로 변환
      String colorName;
      switch (newColor) {
        case 'black':
          colorName = '검정';
          break;
        case 'pink':
          colorName = '핑크';
          break;
        case 'sky':
          colorName = '하늘';
          break;
        default:
          colorName = '원래';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$colorName색으로 염색되었습니다!')));
      return;
    }

    // 챗바퀴 1일권
    if (item['id'] == '1day') {
      provider.useExemptionTicket();
      provider.consumeItem(item['id']); // 사용 시 소모

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('오늘 하루 운동 면제')));
      return;
    }
  }

  // 닉네임 변경 팝업
  void _showNicknameDialog(UserProvider provider, String itemId) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("닉네임 변경"),
        content: TextField(
          controller: textController,
          maxLength: 6,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6), // 6글자 이상 입력 자체를 막음
          ],
          decoration: const InputDecoration(
            hintText: "새 이름을 입력하세요 (최대 6글자)",
            counterText: "", // 글자 수 카운터 숨기기
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                provider.changeNickname(textController.text);
                provider.consumeItem(itemId); // 사용 시 소모
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('이름이 변경되었습니다!')));
              }
            },
            child: const Text("변경"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final myInventoryIds = userProvider.myInventory;
    final equipped = userProvider.equippedItems;
    final myItems = allItemsData.where((item) {
      // 기본 아이템들은 항상 보이게
      if (item['id'].toString().contains('normal')) return true;
      // 내가 가진 아이템만 보이게
      return myInventoryIds.contains(item['id']);
    }).toList();

    // 카테고리 분류
    final equipItems = myItems
        .where((i) => i['category'] != 'consumable')
        .toList();
    final consumableItems = myItems
        .where((i) => i['category'] == 'consumable')
        .toList();

    // 메인 페이지의 햄스터 상태 + 색상을 Provider에서 가져오기
    final String hamsterState = userProvider.currentHamsterState;
    final String hamsterColor = userProvider.hamsterColor;
    String hamsterImagePath;

    if (hamsterColor == 'default') {
      // 기본 색상
      switch (hamsterState) {
        case 'normal':
          hamsterImagePath = 'assets/images/main_images/ham_1.png';
          break;
        case 'fat1':
          hamsterImagePath = 'assets/images/main_images/ham_2.png';
          break;
        case 'fat2':
        default:
          hamsterImagePath = 'assets/images/main_images/ham_3.png';
          break;
      }
    } else {
      // 염색된 색상 (black, pink, sky)
      hamsterImagePath =
          'assets/images/change_images/${hamsterColor}_$hamsterState.png';
    }

    return InventoryScreenUI(
      // Provider에 저장된 장착 이미지 경로 전달
      currentBowl: equipped['bowl'] ?? '',
      currentWater: equipped['water'] ?? '',
      currentWheel: equipped['wheel'] ?? '',
      currentGlass: equipped['glass'],
      currentHair: equipped['hair'],
      hamsterImagePath: hamsterImagePath, // 현재 햄스터 상태

      equipItems: equipItems,
      consumableItems: consumableItems,
      onEquipItem: _equipItem,
    );
  }
}
