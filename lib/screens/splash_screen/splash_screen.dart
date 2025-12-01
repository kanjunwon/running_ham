import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'package:running_ham/screens/main_screen/main_screen.dart';
import 'package:running_ham/screens/tutorial_screen/tutorial_screen.dart';
import 'package:running_ham/screens/tutorial_screen/death_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus(); // 1. 상태 체크 시작
  }

  Future<void> _checkUserStatus() async {
    // 로고 보여주기 위해 2초 정도 딜레이 (로딩척)
    await Future.delayed(const Duration(seconds: 10));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();

    // A. 튜토리얼 봤는지 확인 (기본값 true)
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // B. 마지막 접속일 확인 (죽음 판정용)
    String? lastLoginStr = prefs.getString('lastLoginDate');
    bool isDead = false;

    if (lastLoginStr != null) {
      DateTime lastLogin = DateTime.parse(lastLoginStr);
      DateTime now = DateTime.now();

      // 차이가 7일 이상이면 죽음
      if (now.difference(lastLogin).inDays >= 7) {
        isDead = true;
      }
    }

    // 접속 시간 갱신 (살았든 죽었든 일단 접속은 했으니까)
    await prefs.setString('lastLoginDate', DateTime.now().toIso8601String());

    // C. 화면 이동 로직 (우선순위: 처음 > 죽음 > 메인)
    Widget nextScreen;

    if (isFirstTime) {
      // 1. 처음이면 무조건 튜토리얼
      nextScreen = const TutorialScreen();
    } else if (isDead) {
      // 2. 7일 만에 왔으면 죽음 화면
      nextScreen = const DeathScreen();
    } else {
      // 3. 아니면 메인으로
      nextScreen = const MainScreen();
    }

    if (!mounted) return;

    // 화면 교체 (뒤로가기 방지)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 디자이너가 준 로딩 화면 디자인 (없으면 로고만 띄움)
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 이미지
            Image.asset(
              'assets/images/main_images/ham_1.png', // 임시 로고
              width: 150,
            ),
            const SizedBox(height: 20),
            // 로딩 인디케이터 (빙글빙글)
            const CircularProgressIndicator(color: Color(0xFF4D3817)),
          ],
        ),
      ),
    );
  }
}
