// 보관함 화면

import 'package:flutter/material.dart'; // <--- 1. 이거 추가!

class InventoryScreen extends StatelessWidget { // <--- 2. 이름 추가!
  const InventoryScreen({super.key}); // (이것도 추가해주면 더 좋아)
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 844,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 18,
                top: 59,
                child: Container(
                  width: 18,
                  height: 18,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 174,
                top: 59,
                child: Text(
                  '보관함',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 16,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: -11,
                top: 101,
                child: Container(
                  width: 414,
                  height: 414,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/414x414"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 318,
                top: 93,
                child: Container(
                  width: 119,
                  height: 231,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/119x231"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 262,
                top: 342,
                child: Container(
                  width: 133,
                  height: 72,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/133x72"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -85,
                top: 130,
                child: Container(
                  width: 259,
                  height: 261,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/259x261"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 79,
                top: 183,
                child: Container(
                  width: 231,
                  height: 262,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/231x262"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 47,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 27,
                        top: 14,
                        child: Container(
                          width: 54,
                          height: 21,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 1,
                                child: SizedBox(
                                  width: 54,
                                  height: 20,
                                  child: Text(
                                    '9:41',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w600,
                                      height: 1.31,
                                      letterSpacing: -0.32,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 336,
                        top: 19,
                        child: Container(
                          width: 27.40,
                          height: 13,
                          child: Stack(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 451,
                child: Container(
                  width: 390,
                  height: 376,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F5F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, -4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 810,
                child: Container(
                  width: 390,
                  height: 34,
                  decoration: BoxDecoration(color: const Color(0xFFF8F5F0)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 128,
                        top: 21,
                        child: Container(
                          width: 134,
                          height: 5,
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 297,
                top: 495,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 297,
                top: 589,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 495,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 589,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 713,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 495,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 589,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 713,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 713,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 495,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 589,
                child: Container(
                  width: 70,
                  height: 82,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 514,
                child: Container(
                  width: 50,
                  height: 27,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/50x27"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 553,
                child: Text(
                  '기본 밥그릇',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 309,
                top: 553,
                child: Text(
                  '고급 밥그릇',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 471,
                child: Text(
                  '치장 아이템',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 692,
                child: Text(
                  '소모 아이템',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 553,
                child: Text(
                  '기본 물통',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 647,
                child: Text(
                  '고급 물통',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 771,
                child: Text(
                  '챗바퀴 타기(1일)',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 122,
                top: 771,
                child: Text(
                  '햄스터 염색권',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 218,
                top: 764,
                child: Text(
                  '햄스터\n이름 변경권',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 218,
                top: 553,
                child: Text(
                  '기본 챗바퀴',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 127,
                top: 647,
                child: Text(
                  '고급 챗바퀴',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 223,
                top: 647,
                child: Text(
                  '썬글라스',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 319,
                top: 647,
                child: Text(
                  '머리핀',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 139,
                top: 505,
                child: Container(
                  width: 21,
                  height: 41,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/21x41"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 504,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/42x42"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 307,
                top: 511,
                child: Container(
                  width: 50,
                  height: 33,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/50x33"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 595,
                child: Container(
                  width: 21,
                  height: 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/21x48"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 309,
                top: 604,
                child: Container(
                  width: 48,
                  height: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/48x35"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 123,
                top: 598,
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/54x54"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 269,
                top: 631,
                child: Container(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  width: 56,
                  height: 21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/56x21"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 130,
                top: 727,
                child: Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/39x39"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 721,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/48x48"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 723,
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/43x43"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}