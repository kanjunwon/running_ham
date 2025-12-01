import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:running_ham/screens/main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // 자동 로그인 로직
  Future<void> _checkLoginStatus() async {
    // 1~2초 정도 로고 보여주는 척 (너무 빨리 넘어가면 렉 걸린 줄 암)
    await Future.delayed(const Duration(seconds: 2));

    // 현재 로그인된 유저 확인
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // 이미 로그인된 상태 → 바로 메인으로
      print("자동 로그인 성공! UID: ${user.uid}");
      _navigateToMain();
    } else {
      // 로그인 안 된 상태 → 익명 로그인 시도
      try {
        final userCredential = await FirebaseAuth.instance.signInAnonymously();
        print("신규(익명) 로그인 성공! UID: ${userCredential.user?.uid}");
        _navigateToMain();
      } catch (e) {
        print("로그인 에러: $e");
        // 에러 나면 일단 에러 메시지 띄우거나 재시도 버튼 보여줘야 함
        // (일단은 테스트니까 그냥 메인으로 보내버리기? 아니면 멈추기?)
      }
    }
  }

  void _navigateToMain() {
    // 메인 화면으로 이동 (뒤로가기 해도 스플래시로 못 돌아오게 pushReplacement 사용)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3E6), // 베이지색 배경
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 이미지 (없으면 텍스트)
            Image.asset('assets/images/main_images/ham_1.png', width: 150),
            const SizedBox(height: 20),
            const Text(
              "러닝햄",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D3817),
                fontFamily: 'Recipekorea', // 폰트 적용
              ),
            ),
            const SizedBox(height: 20),
            // 로딩 뺑뺑이
            const CircularProgressIndicator(color: Color(0xFF4D3817)),
          ],
        ),
      ),
    );
  }
}
