import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'package:running_ham/screens/main_screen/main_screen.dart';
import 'package:running_ham/screens/record_screen/record_screen.dart';
import 'package:running_ham/screens/store_screen/store_screen.dart';
import 'package:running_ham/screens/inventory_screen/inventory_screen.dart';
import 'main_screen_widget.dart';

class MainScreenUI extends StatelessWidget {
  final int steps; // 로직 파일로부터 걸음 수 데이터를 전달받음
  final HamsterState hamsterState; // 햄스터 상태 데이터를 전달받음
  final int seedCount; // 재화 (도토리) 데이터
  final bool isHappyMode; // 해피 모드 여부
  final VoidCallback onHamsterTap; // 햄스터 터치 콜백
  final bool isDevMode; // 개발자 모드 여부
  final VoidCallback? onAddSeeds; // 개발자 모드: 도토리 추가
  final VoidCallback? onAddSteps; // 개발자 모드: 걸음 수 추가
  final VoidCallback? onMakeFat; // 개발자 모드: 살찌게
  final VoidCallback? onMakeSlim; // 개발자 모드: 날씬하게

  const MainScreenUI({
    super.key,
    required this.steps,
    required this.hamsterState, // 햄스터 상태도 필수로 받기
    required this.seedCount, // 재화 (도토리) 데이터
    required this.isHappyMode, // 햄스터 터치 롤백
    required this.onHamsterTap, // 해피 모드 여부
    this.isDevMode = false, // 개발자 모드 (기본값 false)
    this.onAddSeeds, // 개발자 모드: 도토리 추가
    this.onAddSteps, // 개발자 모드: 걸음 수 추가
    this.onMakeFat, // 개발자 모드: 살찌게
    this.onMakeSlim, // 개발자 모드: 날씬하게
  });

  @override
  Widget build(BuildContext context) {
    // provider에서 장착된 아이템 정보 가져오기
    final userProvider = context.watch<UserProvider>();
    final equipped = userProvider.equippedItems;
    final nickname = userProvider.nickname;

    // 화면 크기에 따른 비율 조정 (너비 + 높이 모두 고려)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 피그마 기준 화면 크기
    const double baseWidth = 390.0;
    const double baseHeight = 844.0;

    // 너비와 높이 중 더 작은 비율 사용 (화면에 맞게 축소)
    final double scaleWidth = screenWidth / baseWidth;
    final double scaleHeight = screenHeight / baseHeight;
    final double scale = min(scaleWidth, scaleHeight);

    // 비율 적용 헬퍼 함수
    double s(double value) => value * scale;

    // 햄스터 이미지 (색상 + 상태에 따라 결정)
    final hamsterColor = userProvider.hamsterColor;
    String hamsterImagePath;

    if (hamsterColor == 'default') {
      // 기본 색상
      switch (hamsterState) {
        case HamsterState.fat1:
          hamsterImagePath = 'assets/images/main_images/ham_2.png';
          break;
        case HamsterState.fat2:
          hamsterImagePath = 'assets/images/main_images/ham_3.png';
          break;
        case HamsterState.normal:
        default:
          hamsterImagePath = 'assets/images/main_images/ham_1.png';
      }
    } else {
      // 염색된 색상 (black, pink, sky)
      String stateSuffix;
      switch (hamsterState) {
        case HamsterState.fat1:
          stateSuffix = 'fat1';
          break;
        case HamsterState.fat2:
          stateSuffix = 'fat2';
          break;
        case HamsterState.normal:
        default:
          stateSuffix = 'normal';
      }
      hamsterImagePath =
          'assets/images/change_images/${hamsterColor}_$stateSuffix.png';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // 톳밥 아래 그라데이션 (down_ground)
          Positioned(
            top: s(550), // 톳밥 밑에 붙게
            left: 0,
            right: 0,
            bottom: 0, // 화면 하단까지
            child: Image.asset(
              'assets/images/main_images/down_ground.png',
              fit: BoxFit.fill,
              cacheWidth:
                  (screenWidth * MediaQuery.of(context).devicePixelRatio)
                      .toInt(),
            ),
          ),

          // 톳밥 (바닥)
          Positioned(
            top: s(430),
            left: 0,
            right: 0,
            height: s(130), // 톳밥 높이
            child: Image.asset(
              'assets/images/main_images/ground.png',
              fit: BoxFit.fill,
              cacheWidth:
                  (screenWidth * MediaQuery.of(context).devicePixelRatio)
                      .toInt(),
            ),
          ),

          // 물그릇, 밥그릇, 챗바퀴 (함수 호출)
          _buildWheel(equipped['wheel']!, scale),
          _buildWater(equipped['water']!, scale),
          _buildBowl(equipped['bowl']!, scale),

          // 햄스터 + 터치 상호작용 + 치장
          Positioned(
            left: 0,
            right: 0,
            top: hamsterState == HamsterState.normal
                ? s(240)
                : s(220), // 살찐 햄스터는 위로
            child: GestureDetector(
              onTap: onHamsterTap, // 터치하면 카운트 증가
              child: Center(
                child: SizedBox(
                  width: hamsterState == HamsterState.normal ? s(231) : s(270),
                  height: hamsterState == HamsterState.normal ? s(262) : s(300),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // 햄스터 본체 (염색 여부 상관없이 동일한 크기)
                      Image.asset(
                        hamsterImagePath,
                        width: hamsterState == HamsterState.normal
                            ? s(231)
                            : s(270),
                        height: hamsterState == HamsterState.normal
                            ? s(262)
                            : s(300),
                        fit: BoxFit.contain,
                        cacheWidth: hamsterState == HamsterState.normal
                            ? (s(231) * 2).toInt()
                            : (s(270) * 2).toInt(),
                      ),

                      // 볼터치 (햄스터 상태에 따라 위치 조정)
                      if (isHappyMode)
                        Positioned(
                          top: hamsterState == HamsterState.normal
                              ? s(-60)
                              : hamsterState == HamsterState.fat1
                              ? s(-50) // fat1
                              : s(-49), // fat2
                          left: hamsterState == HamsterState.normal
                              ? s(-62)
                              : hamsterState == HamsterState.fat1
                              ? s(-58) // fat1
                              : s(-47), // fat2
                          child: Image.asset(
                            'assets/images/main_images/blush.png',
                            width: hamsterState == HamsterState.normal
                                ? s(360)
                                : hamsterState == HamsterState.fat1
                                ? s(380) // fat1
                                : s(370), // fat2
                            cacheWidth: (s(420) * 2).toInt(),
                          ),
                        ),

                      // 치장 아이템 (선글라스)
                      if (equipped['glass'] != null &&
                          equipped['glass']!.isNotEmpty)
                        _buildAccessory(
                          equipped['glass']!,
                          scale,
                          hamsterState,
                        ),

                      // 치장 아이템 (머리핀)
                      if (equipped['hair'] != null &&
                          equipped['hair']!.isNotEmpty)
                        _buildAccessory(equipped['hair']!, scale, hamsterState),

                      // 하트
                      if (isHappyMode)
                        Positioned(
                          top: s(-40), // 햄스터 머리 위
                          child: Image.asset(
                            'assets/images/main_images/heart.png',
                            width: s(50),
                            cacheWidth: (s(50) * 2).toInt(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 개발자 모드 버튼 (왼쪽 상단)
          if (isDevMode)
            Positioned(
              left: s(10),
              top: 0,
              child: SafeArea(
                child: Row(
                  children: [
                    // 도토리 +100 버튼
                    GestureDetector(
                      onTap: onAddSeeds,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: s(8),
                          vertical: s(4),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(s(8)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/main_images/money_main_back.png',
                              width: s(14),
                              height: s(14),
                            ),
                            SizedBox(width: s(2)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: s(6)),
                    // 걸음 +100 버튼
                    GestureDetector(
                      onTap: onAddSteps,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: s(8),
                          vertical: s(4),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE76F6F).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(s(8)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.directions_walk,
                              size: s(14),
                              color: Colors.white,
                            ),
                            SizedBox(width: s(2)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: s(6)),
                    // 살찌게 버튼
                    GestureDetector(
                      onTap: onMakeFat,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: s(8),
                          vertical: s(4),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9800).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(s(8)),
                        ),
                        child: Text('🐷', style: TextStyle(fontSize: s(12))),
                      ),
                    ),
                    SizedBox(width: s(6)),
                    // 날씬하게 버튼
                    GestureDetector(
                      onTap: onMakeSlim,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: s(8),
                          vertical: s(4),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(s(8)),
                        ),
                        child: Text('🏃', style: TextStyle(fontSize: s(12))),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 상단 도토리 표시
          Positioned(
            right: s(20),
            top: 0,
            child: SafeArea(
              child: Row(
                children: [
                  // 도토리 아이콘
                  Image.asset(
                    'assets/images/main_images/money_main_back.png',
                    width: s(20),
                    height: s(20),
                  ),

                  // 도토리 개수 텍스트
                  SizedBox(width: s(4)),
                  Text(
                    '$seedCount',
                    style: TextStyle(
                      color: Colors.brown.shade700,
                      fontSize: s(15),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 오늘의 걸음 수 (텍스트)
          Positioned(
            left: s(20),
            top: s(80),
            child: Text(
              '오늘의 걸음 수',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: s(15),
                fontFamily: 'Pretendard', // 폰트 적용
                fontWeight: FontWeight.w600, // 볼드체
              ),
            ),
          ),

          // 오늘의 걸음 수 (데이터)
          Positioned(
            left: s(20),
            top: s(110),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: steps < 0 ? (steps == -1 ? '!' : '?') : '$steps',
                    style: TextStyle(
                      color: const Color(0xFFE45151),
                      fontSize: s(32),
                      fontFamily: 'Recipekorea', // 폰트 적용
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextSpan(
                    text: ' 걸음',
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontSize: s(16),
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 2.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 이름
          Positioned(
            left: 0,
            right: 0,
            top: s(500), // 하단 카드에 안 겹치도록 위치 조정
            child: Text(
              nickname, // 변수로 받기
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1A1A1A),
                fontSize: s(20),
                fontFamily: 'Recipekorea', // 폰트 적용
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // 하단 카드
          Positioned(
            left: s(20),
            right: s(20),
            bottom: s(40),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: s(20), vertical: s(20)),
              decoration: ShapeDecoration(
                color: Colors.white, // 카드 배경색
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(s(25)),
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: s(8),
                    offset: Offset(0, s(4)),
                  ),
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
                          text: '${userProvider.attendanceDays}',
                          style: TextStyle(
                            color: const Color(0xFFE76F6F),
                            fontSize: s(20),
                            fontFamily: 'Recipekorea',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: ' 일째 운동중!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: s(16),
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: s(15)),

                  // 헬퍼 함수 프로그레스 바 호출
                  ProgressBar(currentSteps: steps),

                  // 메뉴 버튼 호출
                  SizedBox(height: s(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 운동 기록
                      MenuButton(
                        imagePath: 'assets/images/main_images/record_icon.png',
                        label: '운동 기록',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecordScreen(),
                          ),
                        ),
                      ),

                      // 상점
                      MenuButton(
                        imagePath: 'assets/images/main_images/store_icon.png',
                        label: '상점',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StoreScreen(),
                          ),
                        ),
                      ),

                      // 보관함
                      MenuButton(
                        imagePath:
                            'assets/images/main_images/inventory_icon.png',
                        label: '보관함',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InventoryScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 챗바퀴 위치 조절 함수
  Widget _buildWheel(String imagePath, double scale) {
    double top = 208 * scale;
    double left = -60 * scale;
    double width = 259 * scale;
    double height = 261 * scale;

    // 고급 챗바퀴 좌표 수정
    if (imagePath.contains('rare')) {
      top = 215 * scale;
      left = -55 * scale;
    }

    // 최고급 챗바퀴 좌표 수정 - 바닥에 붙게
    if (imagePath.contains('epic')) {
      top = 210 * scale;
      left = -55 * scale;
    }

    return Positioned(
      top: top,
      left: left,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        cacheWidth: (width * 2).toInt(),
      ),
    );
  }

  // 물통 위치 조절 함수
  Widget _buildWater(String imagePath, double scale) {
    double top = 198 * scale;
    double right = -40 * scale;
    double width = 130 * scale;
    double height = 250 * scale;

    // 고급 물통 좌표 수정
    if (imagePath.contains('rare')) {
      top = 185 * scale;
      right = -35 * scale;
    }

    // 최고급 물통 좌표 수정 - 크기 키우고 바닥에 붙게
    if (imagePath.contains('epic')) {
      width = 207 * scale;
      height = 357 * scale;
      top = 219 * scale;
      right = -65 * scale;
    }

    return Positioned(
      top: top,
      right: right,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        cacheWidth: (width * 2).toInt(),
      ),
    );
  }

  // 밥그릇 위치 조절 함수 (보관함과 동일한 비율)
  Widget _buildBowl(String imagePath, double scale) {
    double bottom = 285 * scale;
    double right = 15 * scale;
    double width = 130 * scale;
    double height = 110 * scale;

    // 고급 밥그릇 좌표 수정
    if (imagePath.contains('rare')) {
      bottom = 293 * scale;
      right = 18 * scale;
      width = 135 * scale;
      height = 100 * scale;
    }

    // 최고급 밥그릇 좌표 수정
    if (imagePath.contains('epic')) {
      bottom = 301 * scale;
      right = 20 * scale;
      width = 140 * scale;
      height = 93 * scale;
    }

    return Positioned(
      bottom: bottom,
      right: right,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        cacheWidth: (width * 2).toInt(),
      ),
    );
  }

  // 액세서리 위치 조절 함수 (햄스터 상태에 따라 조정)
  Widget _buildAccessory(String imagePath, double scale, HamsterState state) {
    double top = 0;
    double left = 0;
    double width = 100 * scale;

    if (imagePath.contains('sunglass')) {
      // 선글라스 위치 (normal / fat1 / fat2)
      switch (state) {
        case HamsterState.normal:
          top = 64 * scale;
          left = 43 * scale;
          width = 150 * scale;
          break;
        case HamsterState.fat1:
          top = 75 * scale;
          left = 47 * scale;
          width = 175 * scale;
          break;
        case HamsterState.fat2:
          top = 74 * scale;
          left = 51 * scale;
          width = 173 * scale;
          break;
      }
    } else if (imagePath.contains('hairpin')) {
      // 머리핀 위치 (normal / fat1 / fat2)
      switch (state) {
        case HamsterState.normal:
          top = 7 * scale;
          left = 130 * scale;
          width = 80 * scale;
          break;
        case HamsterState.fat1:
          top = 10 * scale;
          left = 152 * scale;
          width = 95 * scale;
          break;
        case HamsterState.fat2:
          top = 12 * scale;
          left = 155 * scale;
          width = 85 * scale;
          break;
      }
    }

    return Positioned(
      top: top,
      left: left,
      child: Image.asset(
        imagePath,
        width: width,
        fit: BoxFit.contain,
        cacheWidth: (width * 2).toInt(),
      ),
    );
  }
}
