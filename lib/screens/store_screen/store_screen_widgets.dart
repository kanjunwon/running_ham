import 'package:flutter/material.dart';

// 개별 아이템 카드 위젯
class StoreItemCard extends StatelessWidget {
  final String name;
  final int price;
  final String imagePath;
  final bool isOwned;
  final VoidCallback? onTap; // 탭 했을 때 실행할 함수

  const StoreItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.isOwned,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 카드 전체 배경
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이미지 박스
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0), // 여백 좀 더 넉넉하게
                child: Opacity(
                  opacity: isOwned ? 0.5 : 1.0, // 보유중이면 흐리게
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    cacheWidth: 300, // 이미지 해상도 조절
                    errorBuilder: (c, e, s) => const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            // 아이템 이름
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF4D3817), // 진한 갈색
                fontSize: 14, // 폰트 크기
                fontWeight: FontWeight.w500, // 굵기 조정
                fontFamily: 'Pretendard', // 폰트 적용
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // 가격 또는 보유중 표시
            isOwned
                ? const Text(
                    "보유중",
                    style: TextStyle(
                      color: Colors.grey, // 회색 텍스트
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 도토리 아이콘
                      Image.asset(
                        'assets/images/main_images/money_main_back.png',
                        width: 16,
                      ),
                      const SizedBox(width: 4),

                      // 가격 텍스트
                      Text(
                        "$price",
                        style: const TextStyle(
                          color: Color(0xFF4D3817), // 진한 갈색
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

            const SizedBox(height: 15), // 하단 여백 추가
          ],
        ),
      ),
    );
  }
}
