// 메인페이지 UI 코드

import 'package:flutter/material.dart';
import 'package:running_ham/screens/main_screen/main_screen.dart'; // HamsterState를 쓰기 위해 로직 파일 import
import 'package:running_ham/screens/record_screen/record_screen.dart';
import 'package:running_ham/screens/store_screen/store_screen.dart';
import 'package:running_ham/screens/inventory_screen/inventory_screen.dart';
import 'main_screen_widget.dart'; // 헬퍼 함수 코드 import

// UI만 담당 StatelessWidget
class MainScreenUI extends StatelessWidget {

  final int steps;  // 로직 파일로부터 걸음 수 데이터를 전달받음
  final HamsterState hamsterState; // 햄스터 상태 데이터를 전달받음
  final int seedCount; // 재화 (도토리) 데이터

  const MainScreenUI({
      super.key,
      required this.steps,
      required this.hamsterState, // 햄스터 상태도 필수로 받기
      required this.seedCount, // 재화 (도토리) 데이터
    });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const designWidth = 390.0;

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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SizedBox(
            width: designWidth,
            height: 844,
            child: Stack(
              clipBehavior: Clip.none,
              children: [

                // 톳밥 (바닥 배경)
                Positioned(
                  top: 400, // 햄스터 발밑 좌표
                  left: 0,
                  right: 0,
                  height: 300, // 톳밥 높이
                  child: Image.asset(
                    'assets/images/main_images/ground.png',
                    fit: BoxFit.fill, // 화면에 꽉 차게
                  ),
                ),

                // 챗바퀴 (배경)
                Positioned(
                  top: 195,  // 햄스터랑 비슷한 위치 (값 조절하기)
                  left: -60,  // 왼쪽으로 치우치게 (값 조절하기)
                  child: Image.asset(
                    'assets/images/main_images/chat_normal_back.png',
                    width: 259, // 햄스터보다 조금 작게 (값 조절하기)
                    height: 261,
                  ),
                ),

                // 밥그릇 (배경)
                Positioned(
                  top: 410,   // 햄스터: 180
                  right: 10,   // 햄스터 중앙보다 오른쪽
                  child: Image.asset(
                    'assets/images/main_images/food_normal_back.png',
                    width: 133,
                    height: 72,
                  ),
                ),

                // 햄스터
                Positioned(
                  left: 30,
                  right: 30,
                  top: 240,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 231,
                      height: 262,
                      child: Image.asset(
                        // 상태에 따라 바뀐 이미지
                        hamsterImagePath, 
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // 물그릇
                Positioned(
                  top: 150,    // 햄스터: 180
                  right: -50,   // 햄스터 중앙보다 오른쪽
                  child: Image.asset(
                    'assets/images/main_images/water_normal_back.png',
                    width: 119,
                    height: 231, // (물통은 길쭉하니까)
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
                            icon: Icon(Icons.settings_outlined, color: Colors.grey.shade700),
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

                              const SizedBox(width: 4),
                              // 재화 (150)
                              Text(
                                '$seedCount',  // 나중에 변수로 받아야 함
                                style: TextStyle(
                                  color: Colors.brown.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'AppleSDGothicNeoB00' // 폰트 적용
                                ),
                              ),

                              const SizedBox(width: 8), // 재화와 알람 사이 간격
                              // 알람 아이콘 (종 모양)
                              IconButton(
                                icon: Icon(Icons.notifications_outlined, color: Colors.grey.shade700),
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
                      fontWeight: FontWeight.bold,  // 볼드체
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
                            fontFamily: 'Recipekorea',  // 폰트 적용
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const TextSpan(
                          text: ' 걸음',
                          style: TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 16,
                              fontFamily: 'AppleSDGothicNeoB00',  // 폰트 적용
                              fontWeight: FontWeight.w400,
                              height: 2.2),
                        ),
                      ],
                    ),
                  ),
                ),

                // 김햄찌 텍스트
                Positioned(
                  left: 0,
                  right: 0,
                  top: 500,
                  child: Text(
                    '김햄찌', // 나중에 변수로 바꿔야 함.
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontFamily: 'Recipekorea',  // 폰트 적용
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // 하단 카드
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
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
                                text: '3',  // 나중에 변수로 바꿔야 함.
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
                        const SizedBox(height: 20),

                        // 헬퍼 함수 프로그레스 바 호출
                        ProgressBar(currentSteps: steps),

                        const SizedBox(height: 30),

                        // 메뉴 버튼 호출
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 운동 기록
                            MenuButton(
                              imagePath:
                                  'assets/images/main_images/record_icon.png',
                              label: '운동 기록',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RecordScreen()),
                                );
                              },
                            ),

                            // 상점
                            MenuButton(
                              imagePath:
                                  'assets/images/main_images/store_icon.png',
                              label: '상점',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const StoreScreen()),
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
                                      builder: (context) =>
                                          const InventoryScreen()),
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
          ),
        ),
      ),
    );
  }
}