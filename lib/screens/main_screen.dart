import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
// [추가!] 권한 전문가 불러오기
import 'package:permission_handler/permission_handler.dart';
import 'package:running_ham/screens/record_screen.dart';
import 'package:running_ham/screens/store_screen.dart';
import 'package:running_ham/screens/inventory_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StreamSubscription<StepCount>? _stepCountStreamSubscription; // [수정!] 구독 관리 변수
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // [수정!] initState에서 호출할 비동기 초기화 함수 분리
  Future<void> initPlatformState() async {
    // [수정!] permission_handler를 사용한 권한 요청 로직
    if (await Permission.activityRecognition.request().isGranted) {
      // 권한이 있으면 만보기 스트림 시작
      startListening();
    } else {
      // 권한이 거부된 경우 처리
      print("신체 활동 권한 거부됨");
      if (mounted) setState(() => _steps = -2); // 권한 거부 시 -2
    }
  }


  void startListening() {
    // [수정!] 스트림 구독을 변수에 저장
    _stepCountStreamSubscription = Pedometer.stepCountStream.listen((StepCount event) {
      if (!mounted) return;
      setState(() {
        // [개선!] 누적 걸음수 대신, 앱 실행 후 걸음수 계산 (선택 사항)
        // 만약 센서가 앱 재시작 시 0부터 시작하지 않는 경우 필요할 수 있음
        // final todaySteps = event.steps - _initialSteps; // _initialSteps 필요
        _steps = event.steps;
      });
    }, onError: (error) {
      if (!mounted) return;
      print("만보기 에러: $error");
      setState(() {
        _steps = -1; // 에러 시 -1
      });
    });
  }

  // [추가!] 화면이 사라질 때 스트림 구독 취소 (메모리 누수 방지)
  @override
  void dispose() {
    _stepCountStreamSubscription?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const designWidth = 390.0;
    final scale = screenWidth / designWidth;

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
                // ... (배경 그라데이션, 햄스터 이미지 등 기존 UI 코드는 동일) ...
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
                          image: NetworkImage("https://placehold.co/250x250/EFEFEF/AAAAAA&text=Hamster"), // [TODO] 진짜 햄스터 이미지
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
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
                               IconButton(
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
                          text: _steps < 0 ? (_steps == -1 ? '!' : '?') : '$_steps',
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


                // --- 하단 카드 ---
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

                        _buildProgressBar(_steps),

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

  // ... (_buildProgressBar 함수는 이전과 동일) ...
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
                    child: Text('${_steps < 0 ? 0 : _steps}보', style: const TextStyle(fontSize: 12)),
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
            builder: (context, constraints){
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
                    child: Container(width: 2, height: 16, color: Colors.white)
                  ),
                   Positioned(
                    left: barWidth * reward2Progress - 1,
                    child: Container(width: 2, height: 16, color: Colors.white)
                  ),
                  Positioned(
                    left: (barWidth * progress - 10).clamp(0.0, barWidth - 20),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE76F6F),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)
                      ),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ],
    );
  }


  // ... (_buildMenuButton 함수는 이전과 동일) ...
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
               offset: const Offset(0, 2)
             )
          ]
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

