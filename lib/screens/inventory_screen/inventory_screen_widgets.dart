import 'package:flutter/material.dart';

class InventoryItemCard extends StatelessWidget {
  final String name;
  final String imagePath; // 목록에 보여줄 작은 이미지
  final bool isEquipped; // 장착 중인지?
  final VoidCallback onTap; // 눌렀을 때 실행할 함수

  const InventoryItemCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.isEquipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // 아이템 이미지 박스
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),

              // 장착 중이면 분홍색 테두리
              border: Border.all(
                color: isEquipped
                    ? const Color(0xFFE76F6F)
                    : Colors.grey.shade200,
                width: isEquipped ? 2 : 1,
              ),

              // 장착 중이면 살짝 그림자
              boxShadow: [
                if (isEquipped)
                  BoxShadow(
                    color: const Color(0xFFE76F6F).withOpacity(0.2),
                    blurRadius: 4,
                  ),
              ],
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    const Icon(Icons.help_outline, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 5),

          // 아이템 이름
          Text(
            name,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF4D3817),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
