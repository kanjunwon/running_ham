// 메인페이지 헬퍼 함수 코드

import 'package:flutter/material.dart';

// 프로그레스 바
class ProgressBar extends StatelessWidget {
  final int currentSteps;
  const ProgressBar({super.key, required this.currentSteps});

  @override
  Widget build(BuildContext context) {
    const goalSteps = 10000; // 목표 1만보
    const reward1Steps = 5000; // 보상 5천보
    const reward2Steps = 10000; // 보상 1만보

    // 걸음 수가 0 미만이면 0으로, 1만 초과면 1만으로 고정
    int displaySteps = currentSteps < 0 ? 0 : currentSteps;

    // 0.0~1.0 사이의 값
    double progress = (displaySteps / goalSteps).clamp(0.0, 1.0);
    double reward1Progress = reward1Steps / goalSteps;
    double reward2Progress = reward2Steps / goalSteps;

    return Column(
      children: [
        //...보, 50개, 100개 텍스트
        SizedBox(
          height: 15, // 라벨 텍스트가 표시될 여유 공간
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;
              return Stack(
                clipBehavior: Clip.none, // 밖으로 튀어나가도 보이게
                children: [
                  Positioned(
                    left: 0,
                    bottom: -15, // 게이지 바 아래에 텍스트 배치
                    child: Text('$displaySteps보', style: const TextStyle(fontSize: 15, fontFamily: 'AppleSDGothicNeoM00')),
                  ),
                  Positioned(
                    left: barWidth * reward1Progress - 15,
                    bottom: -15,
                    child: const Text('50개 ', style: TextStyle(fontSize: 15, fontFamily: 'AppleSDGothicNeoM00')),
                  ),
                  Positioned(
                    right: 0,
                    bottom: -15,
                    child: const Text('100개', style: TextStyle(fontSize: 15, fontFamily: 'AppleSDGothicNeoM00')),
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
              if (barWidth == 0) {
                return const SizedBox(height: 20); // 0이면 빈 공간                
              }
              
              final double maxHandleLeft = (barWidth - 20).clamp(0.0, double.infinity); // (barWidth - 20)이 음수가 되지 않도록, 0.0으로 최소값 고정
              final double calculatedHandleLeft = barWidth * progress - 10; // 게이지 핸들의 계산된 위치

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
                    left: -3, // 게이지 바 시작점에 딱 맞추기
                    top: -5, // 게이지 바 위로 살짝 올리기
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        // 빨간 테두리 동그라미 (배경)
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // 흰색 배경
                              border: Border.all(
                                  color: const Color(0xFFE76F6F), width: 2)),
                        ),
                        // 2. 도토리 아이콘 동그라미 위에 겹치기
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            'assets/images/main_images/money_main_back.png',
                            width: 14,
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 게이지 위 동그라미 (움직이는 핸들)
                  Positioned(
                    // clamp 로직 수정
                    left: calculatedHandleLeft.clamp(0.0, maxHandleLeft), 
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
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// 메뉴 버튼
class MenuButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                fontFamily: 'AppleSDGothicNeoM00', // 폰트 적용
                fontWeight: FontWeight.bold,    // 볼드체
              ),
            ),
          ],
        ),
      ),
    );
  }
}