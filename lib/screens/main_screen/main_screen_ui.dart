import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'package:running_ham/screens/main_screen/main_screen.dart';
import 'package:running_ham/screens/record_screen/record_screen.dart';
import 'package:running_ham/screens/store_screen/store_screen.dart';
import 'package:running_ham/screens/inventory_screen/inventory_screen.dart';
import 'main_screen_widget.dart';

// UI만 담당 StatelessWidget
class MainScreenUI extends StatelessWidget {
  final int steps; // 로직 파일로부터 걸음 수 데이터를 전달받음
  final HamsterState hamsterState; // 햄스터 상태 데이터를 전달받음
  final int seedCount; // 재화 (도토리) 데이터
  final int touchCount; // 햄스터 터치 횟수
  final VoidCallback onHamsterTap; // 햄스터 터치 콜백
  final bool isHappyMode; // 해피 모드 여부

  const MainScreenUI({
    super.key,
    required this.steps,
    required this.hamsterState, // 햄스터 상태도 필수로 받기
    required this.seedCount, // 재화 (도토리) 데이터
    required this.touchCount, // 햄스터 터치 횟수
    required this.onHamsterTap, // 햄스터 터치 콜백
    required this.isHappyMode, // 해피 모드 여부
  });

  @override
  Widget build(BuildContext context) {
    // Provider에서 장착된 아이템 정보 가져오기
    final userProvider = context.watch<UserProvider>();
    final equipped = userProvider.equippedItems;
    final nickname = userProvider.nickname;

    // 햄스터 이미지
    String hamsterImagePath;
    switch (hamsterState) {
      case HamsterState.fat1:
        hamsterImagePath = 'assets/images/main_images/ham_2.png'; // 1단계 살찜
        break;
      case HamsterState.fat2:
        hamsterImagePath = 'assets/images/main_images/ham_3.png'; // 2단계 살찜
        break;
      case HamsterState.normal:
      default:
        hamsterImagePath = 'assets/images/main_images/ham_1.png'; // 기본 햄스터
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E6), // 배경색
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // 톳밥 (바닥)
          Positioned(
            top: 400, // 햄스터 발밑 좌표
            left: 0,
            right: 0,
            height: 300, // 톳밥 높이
            child: Image.asset(
              'assets/images/main_images/ground.png',
              fit: BoxFit.fill,
            ),
          ),

          // 물그릇, 밥그릇, 챗바퀴 (함수 호출)
          _buildWheel(equipped['wheel']!),
          _buildWater(equipped['water']!),
          _buildBowl(equipped['bowl']!),

          // 햄스터 + 터치 상호작용 + 치장
          Positioned(
            left: 0,
            right: 0,
            top: 240, // 햄스터 기준 위치
            child: GestureDetector(
              onTap: onHamsterTap, // 터치하면 카운트 증가
              child: Center(
                child: SizedBox(
                  width: 231,
                  height: 262,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // 햄스터 본체
                      Image.asset(hamsterImagePath, fit: BoxFit.contain),

                      // 볼터치
                      if (isHappyMode)
                        Positioned(
                          top: -63,
                          left: -70,
                          child: Image.asset(
                            'assets/images/main_images/blush.png',
                            width: 375,
                          ),
                        ),

                      // 치장 아이템 (선글라스)
                      if (equipped['glass'] != null &&
                          equipped['glass']!.isNotEmpty)
                        _buildAccessory(equipped['glass']!),

                      // 치장 아이템 (머리핀)
                      if (equipped['hair'] != null &&
                          equipped['hair']!.isNotEmpty)
                        _buildAccessory(equipped['hair']!),

                      // 하트
                      if (isHappyMode)
                        Positioned(
                          top: -60, // 햄스터 머리 위
                          child: Image.asset(
                            'assets/images/main_images/heart.png',
                            width: 50,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 상단 버튼 바 (설정, 도토리, 알람)
          Positioned(
            left: 0,
            right: 0,
            top: -5,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        color: Colors.grey.shade700,
                      ),
                      onPressed: () {
                        print("Settings tapped");
                      },
                    ),
                    Row(
                      children: [
                        // 도토리 아이콘
                        Image.asset(
                          'assets/images/main_images/money_main_back.png',
                          width: 20,
                          height: 20,
                        ),

                        // 도토리 개수 텍스트
                        const SizedBox(width: 4),
                        Text(
                          '$seedCount', // 나중에 변수로 받아야 함
                          style: TextStyle(
                            color: Colors.brown.shade700,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AppleSDGothicNeoB00', // 폰트 적용
                          ),
                        ),

                        const SizedBox(width: 8), // 재화와 알람 사이 간격
                        // 알람 아이콘 (종 모양)
                        IconButton(
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: Colors.grey.shade700,
                          ),
                          onPressed: () {
                            print("Notifications tapped");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 오늘의 걸음 수 (텍스트)
          Positioned(
            left: 20,
            top: 80,
            child: Text(
              '오늘의 걸음 수',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 15,
                fontFamily: 'AppleSDGothicNeoM00', // 폰트 적용
                fontWeight: FontWeight.bold, // 볼드체
              ),
            ),
          ),

          // 오늘의 걸음 수 (데이터)
          Positioned(
            left: 20,
            top: 110,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: steps < 0 ? (steps == -1 ? '!' : '?') : '$steps',
                    style: const TextStyle(
                      color: Color(0xFFE45151),
                      fontSize: 32,
                      fontFamily: 'Recipekorea', // 폰트 적용
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: ' 걸음',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 16,
                      fontFamily: 'AppleSDGothicNeoB00', // 폰트 적용
                      fontWeight: FontWeight.w400,
                      height: 2.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 이름
          Positioned(
            left: 0,
            right: 0,
            top: 492, // 하단 카드에 안 겹치도록 위치 조정
            child: Text(
              nickname, // 변수로 받기
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1A1A1A),
                fontSize: 20,
                fontFamily: 'Recipekorea', // 폰트 적용
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // 하단 카드
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: ShapeDecoration(
                color: Colors.white, // 카드 배경색
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              // ~일째 운동중 텍스트
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '3', // 나중에 변수로 바꿔야 함.
                          style: TextStyle(
                            color: const Color(0xFFE76F6F),
                            fontSize: 20,
                            fontFamily: 'Recipekorea',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(
                          text: ' 일째 운동중!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'AppleSDGothicNeoB00',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 헬퍼 함수 프로그레스 바 호출
                  const SizedBox(height: 20),

                  // 메뉴 버튼 호출
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 운동 기록
                      MenuButton(
                        imagePath: 'assets/images/main_images/record_icon.png',
                        label: '운동 기록',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RecordScreen(),
                            ),
                          );
                        },
                      ),

                      // 상점
                      MenuButton(
                        imagePath: 'assets/images/main_images/store_icon.png',
                        label: '상점',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StoreScreen(),
                            ),
                          );
                        },
                      ),

                      // 보관함
                      MenuButton(
                        imagePath:
                            'assets/images/main_images/inventory_icon.png',
                        label: '보관함',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InventoryScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 챗바퀴 위치 조절 함수
  Widget _buildWheel(String imagePath) {
    double top = 195; // [기본값]
    double left = -60; // [기본값]
    double width = 259;
    double height = 261;

    if (imagePath.contains('rare')) {
      top = 260;
      left = -50;
    }

    return Positioned(
      top: top,
      left: left,
      child: Image.asset(imagePath, width: width, height: height),
    );
  }

  // 물통 위치 조절 함수
  Widget _buildWater(String imagePath) {
    double top = 150; // [기본값]
    double right = -50; // [기본값]
    double width = 119;
    double height = 231;

    if (imagePath.contains('rare')) {
      // 고급 물통 좌표 수정
      top = 140;
      right = -40;
    }

    return Positioned(
      top: top,
      right: right,
      child: Image.asset(imagePath, width: width, height: height),
    );
  }

  // 밥그릇 위치 조절 함수
  Widget _buildBowl(String imagePath) {
    double top = 410; // [기본값]
    double right = 10; // [기본값]
    double width = 133;
    double height = 72;

    if (imagePath.contains('rare')) {
      top = 400;
      right = 20;
    }

    return Positioned(
      top: top,
      right: right,
      child: Image.asset(imagePath, width: width, height: height),
    );
  }

  // 액세서리 위치 조절 함수
  Widget _buildAccessory(String imagePath) {
    double top = 0;
    double left = 0;
    double width = 100;

    if (imagePath.contains('sunglass')) {
      // 선글라스 위치
      top = 64;
      left = 43;
      width = 150;
    } else if (imagePath.contains('hairpin')) {
      // 머리핀 위치
      top = 7;
      left = 130;
      width = 80;
    } else {
      // 그 외 아이템 (기본값)
      top = 0;
      left = 0;
    }

    return Positioned(
      top: top,
      left: left,
      child: Image.asset(imagePath, width: width, fit: BoxFit.contain),
    );
  }
}
