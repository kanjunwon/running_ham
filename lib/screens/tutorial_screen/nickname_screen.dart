import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'package:running_ham/screens/main_screen/main_screen.dart';

class NicknameScreen extends StatefulWidget {
  const NicknameScreen({super.key});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  Future<void> _onDecide() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final provider = context.read<UserProvider>();
    provider.setNickname(text); // 닉네임 설정
    await provider.completeTutorial(); // 튜토리얼 완료 처리

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 반응형 스케일링 (너비 + 높이 모두 고려)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    const double baseWidth = 390.0;
    const double baseHeight = 844.0;
    final double scale = min(
      screenWidth / baseWidth,
      screenHeight / baseHeight,
    );
    double s(double value) => value * scale;

    return Scaffold(
      backgroundColor: const Color(0xFFFFBDBD), // 배경색
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: s(80)),

                  // 햄스터
                  Image.asset(
                    'assets/images/main_images/ham_1.png',
                    width: s(250),
                    cacheWidth: (s(250) * 2).toInt(),
                  ),

                  SizedBox(height: s(40)),

                  // 질문 텍스트
                  Text(
                    "햄스터의 이름을 지어주세요",
                    style: TextStyle(
                      fontSize: s(18),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE45151),
                      fontFamily: 'Pretendard',
                    ),
                  ),

                  SizedBox(height: s(20)),

                  // 입력창
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(30)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(s(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        textAlign: TextAlign.center,
                        maxLength: 6,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "최대 6글자",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: s(16),
                          ),
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(vertical: s(15)),
                        ),
                      ),
                    ),
                  ),

                  // 키보드가 올라와도 내용을 볼 수 있게 하단 여백 추가
                  SizedBox(height: s(150)),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: s(40),
            left: s(20),
            right: s(20),
            child: ElevatedButton(
              onPressed: _onDecide,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE86F6F),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: s(23)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                elevation: 0,
              ),
              child: Text(
                "결정!",
                style: TextStyle(fontSize: s(18), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
