import 'package:flutter/material.dart';
import 'package:running_ham/screens/tutorial_screen/nickname_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();

  final List<String> _tutorialImages = [
    'assets/images/tutorial_images/tuto_1.png',
    'assets/images/tutorial_images/tuto_2.png',
    'assets/images/tutorial_images/tuto_3.png',
    'assets/images/tutorial_images/tuto_4.png',
    'assets/images/tutorial_images/tuto_5.png',
    'assets/images/tutorial_images/tuto_6.png',
    'assets/images/tutorial_images/tuto_7.png',
    'assets/images/tutorial_images/tuto_8.png',
    'assets/images/tutorial_images/tuto_9.png',
    'assets/images/tutorial_images/tuto_10.png',
    'assets/images/tutorial_images/tuto_11.png',
    'assets/images/tutorial_images/tuto_12.png',
    'assets/images/tutorial_images/tuto_13.png',
  ];

  int _currentIndex = 0;

  void _goToNickname() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NicknameScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  // 터치 위치에 따라 앞/뒤 이동
  void _handleTap(TapUpDetails details) {
    // 화면 전체 너비 구하기
    final screenWidth = MediaQuery.of(context).size.width;
    // 터치한 x좌표 구하기
    final tapPosition = details.globalPosition.dx;

    // 반으로 나눠서 판별
    if (tapPosition < screenWidth / 2) {
      // 왼쪽 터치 → 이전 페이지
      if (_currentIndex > 0) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      // 오른쪽 터치 → 다음 페이지
      if (_currentIndex < _tutorialImages.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 이미지 최적화를 위한 화면 크기
    final screenWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTapUp: _handleTap,
        child: Stack(
          children: [
            // 슬라이드 화면
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _tutorialImages.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  _tutorialImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  cacheWidth: (screenWidth * devicePixelRatio)
                      .toInt(), // 메모리 최적화
                );
              },
            ),

            // 시작하기 버튼 (마지막 페이지)
            if (_currentIndex == _tutorialImages.length - 1)
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: _goToNickname,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE86F6F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "런닝햄 시작하기",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

            // 건너뛰기 버튼 (마지막 아닐 때)
            if (_currentIndex != _tutorialImages.length - 1)
              Positioned(
                top: 30,
                right: 20,
                child: TextButton(
                  onPressed: _goToNickname,
                  child: const Text(
                    "건너뛰기",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
