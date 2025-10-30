// 메인페이지 UI 코드 (피그마로 그대로 옮겨서 줄여야함)

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
    // 피그마 코드 덩어리 << 줄여야 함.
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
                Positioned(
                  left: 0,
                  right: 0,
                  top: 150,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://placehold.co/250x250/EFEFEF/AAAAAA&text=Hamster"),
                          fit: BoxFit.contain,
                        ),
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
                            onPressed: () { print("Settings tapped"); },
                          ),
                          Row(
                            children: [
                              IconButton( // 알람이 아닌, 도토리가 들어가야함
                                icon: Icon(Icons.notifications_outlined, color: Colors.grey.shade700),
                                onPressed: () { print("Notifications tapped"); },
                              ),
                              const SizedBox(width: 0),
                              Icon(Icons.grain_rounded, color: Colors.brown.shade400, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '150',
                                style: TextStyle(
                                  color: Colors.brown.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
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
                          text: steps < 0 ? (steps == -1 ? '!' : '?') : '$steps', // [수정!] _steps -> steps
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
                            fontFamily: 'AppleSDGothicNeoB00',
                            fontWeight: FontWeight.w400,
                            height: 2.2
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 410,
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
                                  fontFamily: 'AppleSDGothicNeoB00',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // [수정!] _steps -> steps
                        _buildProgressBar(steps), 

                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMenuButton(
                              context: context,
                              icon: Icons.directions_run,
                              iconColor: Colors.orange.shade600,
                              label: '운동 기록',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RecordScreen()),
                                );
                              },
                            ),
                            _buildMenuButton(
                              context: context,
                              icon: Icons.store_outlined,
                              iconColor: Colors.blue.shade600,
                              label: '상점',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const StoreScreen()),
                                );
                              },
                            ),
                            _buildMenuButton(
                              context: context,
                              icon: Icons.inventory_2_outlined,
                              iconColor: Colors.purple.shade600,
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
          height: 15,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    bottom: -15,
                    child: Text('${steps < 0 ? 0 : steps}보', style: const TextStyle(fontSize: 12)), // [수정!] _steps -> steps
                  ),
                  Positioned(
                    left: barWidth * reward1Progress - 15,
                    bottom: -15,
                    child: const Text('50개', style: TextStyle(fontSize: 12)),
                  ),
                  Positioned(
                    right: 0,
                    bottom: -15,
                    child: const Text('100개', style: TextStyle(fontSize: 12)),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10 + 15),
        SizedBox(
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
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
                  Positioned(
                    left: barWidth * reward1Progress - 1,
                    child: Container(width: 2, height: 16, color: Colors.white),
                  ),
                  Positioned(
                    left: barWidth * reward2Progress - 1,
                    child: Container(width: 2, height: 16, color: Colors.white),
                  ),
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
                  )
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
    required IconData icon,
    required String label,
    required Color iconColor,
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
            Icon(icon, size: 35, color: iconColor),
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
