import 'package:flutter/material.dart';
import 'package:running_ham/screens/record_screen/record_screen.dart';
import 'package:running_ham/screens/store_screen/store_screen.dart';
import 'package:running_ham/screens/inventory_screen/inventory_screen.dart';

// UI만 담당 StatelessWidget
class MainScreenUI extends StatelessWidget {
  // 로직 파일로부터 '걸음 수' 데이터를 전달받음
  final int steps;

  const MainScreenUI({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const designWidth = 390.0;

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

                Positioned(
                  // 챗바퀴
                  top: 195,  // 햄스터랑 비슷한 위치 (값 조절하기)
                  left: -60,  // 왼쪽으로 치우치게 (값 조절하기)
                  child: Image.asset(
                    'assets/images/main_images/chat_normal_back.png',
                    width: 259, // 햄스터보다 조금 작게 (값 조절하기)
                    height: 261,
                  ),
                ),

                Positioned(
                  left: 0,
                  top: 582,
                  child: Container(
                    width: 390,
                    height: 262,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [Color(0xFFDDBE97), Color(0x00DDBE97)],
                      ),
                    ),
                  ),
                ),

                // 밥그릇
                Positioned(
                  top: 410,   // 햄스터: 180
                  right: 10,   // 햄스터 중앙보다 오른쪽
                  child: Image.asset(
                    'assets/images/main_images/food_normal_back.png',
                    width: 133,
                    height: 72,
                  ),
                ),

                Positioned(
                  // 김햄찌
                  left: 30,
                  right: 30,
                  top: 250,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 231,
                      height: 262,
                      child: Image.asset(
                        'assets/images/main_images/ham_1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('9:41', style: TextStyle(fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              Icon(Icons.wifi, size: 16, color: Colors.grey.shade700),
                              const SizedBox(width: 4),
                              Icon(Icons.battery_full, size: 16, color: Colors.grey.shade700),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 50,
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
                              // 2. 재화 (150)
                              Text(
                                '150',
                                style: TextStyle(
                                  color: Colors.brown.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
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

                Positioned(
                  left: 20,
                  top: 111 + 30,
                  child: Text(
                    '오늘의 걸음 수',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 15,
                      fontFamily: 'Recipekrea',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                Positioned(
                  left: 20,
                  top: 140 + 30,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: steps < 0 ? (steps == -1 ? '!' : '?') : '$steps',
                          style: const TextStyle(
                            color: Color(0xFFE45151),
                            fontSize: 32,
                            fontFamily: 'Recipekorea',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' 걸음',
                          style: TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 16,
                              fontFamily: 'AppleSDGothicNeoB',
                              fontWeight: FontWeight.w400,
                              height: 2.2),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  top: 500,
                  child: Text(
                    '김햄찌',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: 20,
                      fontFamily: 'Recipekorea',
                      fontWeight: FontWeight.w400,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '3',
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
                                  fontFamily: 'AppleSDGothicNeoB',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildProgressBar(steps),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 운동 기록
                            _buildMenuButton(
                              context: context,
                              imagePath: 'assets/images/main_images/record_icon.png',
                              label: '운동 기록',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RecordScreen()),
                                );
                              },
                            ),

                            // 상점
                            _buildMenuButton(
                              context: context,
                              imagePath: 'assets/images/main_images/store_icon.png',
                              label: '상점',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const StoreScreen()),
                                );
                              },
                            ),

                            // 보관함
                            _buildMenuButton(
                              context: context,
                              imagePath: 'assets/images/main_images/inventory_icon.png',
                              label: '보관함',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const InventoryScreen()),
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

  // --- (여기부터는 '헬퍼 함수'들) ---

  Widget _buildProgressBar(int currentSteps) {
    const goalSteps = 10000;
    const reward1Steps = 5000;
    const reward2Steps = 10000;

    double progress = currentSteps < 0 ? 0 : (currentSteps / goalSteps).clamp(0.0, 1.0);
    double reward1Progress = reward1Steps / goalSteps;
    double reward2Progress = reward2Steps / goalSteps;

    return Column(
      children: [
        SizedBox(
          height: 15, // 라벨 텍스트가 표시될 여유 공간
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              return Stack(
                clipBehavior: Clip.none, // 밖으로 튀어나가도 보이게
                children: [
                  // '걸음 수' 텍스트만 남김 (도토리 아이콘 삭제)
                  Positioned(
                    left: 0,
                    bottom: -15, // 게이지 바 아래에 텍스트 배치
                    child: Text('${steps < 0 ? 0 : steps}보', style: const TextStyle(fontSize: 15)),
                  ),

                  Positioned( 
                    left: barWidth * reward1Progress - 15,
                    bottom: -15,
                    child: const Text('50개 ', style: TextStyle(fontSize: 15)),
                  ),

                  Positioned(
                    right: 0,
                    bottom: -15,
                    child: const Text('100개', style: TextStyle(fontSize: 15)),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 10 + 15), // 라벨 높이만큼 간격 추가
        SizedBox(
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              return Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none, // 밖으로 튀어나가는 도토리 보이게
                children: [
                  // 뒷 배경 바
                  Container(
                    width: barWidth,
                    height: 16,
                    decoration: ShapeDecoration(
                      color: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  // 채워진 바
                  Container(
                    width: barWidth * progress,
                    height: 16,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE76F6F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  // 5000보 구분선
                  Positioned(
                    left: barWidth * reward1Progress - 1,
                    child: Container(width: 2, height: 16, color: Colors.white),
                  ),

                  // 10000보 구분선
                  Positioned(
                    left: barWidth * reward2Progress - 1,
                    child: Container(width: 2, height: 16, color: Colors.white),
                  ),

                  // 게이지 위 동그라미
                  Positioned(
                    left: (barWidth * progress - 10).clamp(0.0, barWidth - 20),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE76F6F),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  // '...보' 텍스트와 분리해서 게이지 바 Stack으로 옮김
                  Positioned( 
                    // 게이지 바 위에 딱 맞게 좌표 수정
                    left: 0,
                    top: -5, // 게이지 바(height: 16)의 중앙(-10) + 아이콘 높이(-10) = -5 (대충)
                    child: Container(
                      width: 26, // 아이콘 크기 (동그라미 보다 크게)
                      height: 26,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white, // 흰색 배경
                          border: Border.all(color: const Color(0xFFE76F6F), width: 2)),
                      child: Image.asset(
                        'assets/images/main_images/money_main_back.png',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required BuildContext context,
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        height: 80,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 35, // 가로 크기
              height: 35, // 세로 크기
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}