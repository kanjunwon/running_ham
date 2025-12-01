import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'package:running_ham/screens/tutorial_screen/tutorial_screen.dart';

class DeathScreen extends StatelessWidget {
  const DeathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 반응형 스케일링 로직
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = min(screenWidth / 390.0, 1.1);
    double s(double value) => value * scale;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E6), // 메인과 동일한 배경색
      body: Stack(
        children: [
          // 1. 흙 바닥 배경
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: s(300),
            child: Image.asset(
              'assets/images/main_images/ground.png',
              fit: BoxFit.fill,
              cacheWidth:
                  (screenWidth * MediaQuery.of(context).devicePixelRatio)
                      .toInt(),
            ),
          ),

          // 2. 유령 햄스터 & 이름
          Positioned(
            top: s(180),
            left: 0,
            right: 0,
            child: Column(
              children: [
                // 유령 햄스터 이미지 (없으면 기본 햄스터라도 띄워놔야 에러 안 남)
                Image.asset(
                  'assets/images/tutorail_images/death_ham.png',
                  width: s(220),
                  cacheWidth: (s(220) * 2).toInt(),
                ),
                SizedBox(height: s(10)),
                // 죽은 햄스터 이름
                Text(
                  context.watch<UserProvider>().nickname, // 죽은 햄스터 이름 불러오기
                  style: TextStyle(
                    fontSize: s(24),
                    fontFamily: 'Recipekorea', // 게임 폰트
                    color: Colors.black.withOpacity(0.6), // 죽었으니 약간 흐리게
                  ),
                ),
              ],
            ),
          ),

          // 3. 하단 대화창 (클릭 시 부활/초기화)
          Positioned(
            bottom: s(60),
            left: s(20),
            right: s(20),
            child: GestureDetector(
              onTap: () async {
                // [중요] 데이터 초기화하고 튜토리얼로 이동
                final provider = context.read<UserProvider>();
                await provider.resetData(); // Provider에 이 함수 있어야 함!

                if (!context.mounted) return;

                // 튜토리얼로 이동 (뒤로가기 방지)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TutorialScreen(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(s(20)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(s(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "당신의 햄스터는 돌봄받지 못해 죽었습니다.\n새로운 햄스터를 키우시겠습니까?",
                      style: TextStyle(
                        fontSize: s(16),
                        fontFamily: 'Pretendard',
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: s(10)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: const Color(0xFFE45151),
                        size: s(30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
