import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  // 햄스터 애니메이션용 변수들
  int _currentHamsterIndex = 0;
  Timer? _hamsterTimer;
  final List<String> _hamsterImages = [
    'assets/images/splash_images/loading_1.png', // 로딩 1
    'assets/images/splash_images/loading_2.png', // 로딩 2
    'assets/images/splash_images/loading_3.png', // 로딩 3
  ];

  @override
  void initState() {
    super.initState();
    _startHamsterAnimation(); // 햄스터 애니메이션 시작
    _checkUserStatus(); // 유저 상태 체크 시작
  }

  @override
  void dispose() {
    _hamsterTimer?.cancel(); // 화면 종료 시 타이머 해제 (메모리 누수 방지)
    super.dispose();
  }

  // 0.5초마다 햄스터 이미지 바꾸는 타이머
  void _startHamsterAnimation() {
    _hamsterTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _currentHamsterIndex =
              (_currentHamsterIndex + 1) % _hamsterImages.length;
        });
      }
    });
  }

  Future<void> _checkUserStatus() async {
    // Firebase 익명 로그인 + 데이터 불러오기
    await context.read<UserProvider>().initializeUser();

    // 로고 보여주기 위해 1초 정도 딜레이
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();

    // 튜토리얼 봤는지 확인 (기본값 true)
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // 마지막 접속일 확인 (죽음 판정용)
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

    // 접속 시간 갱신
    await prefs.setString('lastLoginDate', DateTime.now().toIso8601String());

    // 화면 이동 로직 (우선순위: 처음 > 죽음 > 메인)
    Widget nextScreen;

    if (isFirstTime) {
      // 처음이면 무조건 튜토리얼
      nextScreen = const TutorialScreen();
    } else if (isDead) {
      // 7일 만에 왔으면 죽음 화면
      nextScreen = const DeathScreen();
    } else {
      // 아니면 메인으로
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
      backgroundColor: const Color(0xFFFFD5D5), // 디자인 시안 배경색
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 런 / 닝 / 햄 위치에 번갈아 나타남
            SizedBox(
              width: s(200), // 로고 너비와 맞춤
              height: s(90),
              child: Row(
                children: List.generate(3, (index) {
                  // 첫번째 / 두,세번째 크기
                  final double hamsterSize = index == 0 ? s(110) : s(70);
                  return Expanded(
                    child: Center(
                      // 현재 인덱스만 보여주고, 나머지는 빈 공간
                      child: _currentHamsterIndex == index
                          ? Image.asset(
                              _hamsterImages[index],
                              width: hamsterSize,
                              height: hamsterSize,
                              cacheWidth: (hamsterSize * 2).toInt(),
                              fit: BoxFit.contain,
                            )
                          : SizedBox(width: hamsterSize, height: hamsterSize),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: s(10)), // 햄스터와 로고 사이 간격
            // 런닝햄 텍스트 로고
            Image.asset(
              'assets/images/splash_images/logo.png',
              width: s(200),
              cacheWidth: (s(200) * 2).toInt(),
            ),
          ],
        ),
      ),
    );
  }
}
