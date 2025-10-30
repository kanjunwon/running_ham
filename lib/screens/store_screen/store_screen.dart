// 상점 화면

import 'package:flutter/material.dart'; // <--- 1. 이거 추가!

class StoreScreen extends StatelessWidget { // <--- 2. 이름 추가!
  const StoreScreen({super.key}); // (이것도 추가해주면 더 좋아)
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
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 852,
                  decoration: BoxDecoration(color: const Color(0xFFF7F5F0)),
                ),
              ),
              Positioned(
                left: 24,
                top: 478,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 536,
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
                left: 49,
                top: 490,
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
                left: 56,
                top: 555,
                child: Text(
                  '1000',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 478,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 536,
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
                left: 140,
                top: 483,
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
                left: 147,
                top: 555,
                child: Text(
                  '1500',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
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
                top: 810,
                child: Container(
                  width: 390,
                  height: 34,
                  decoration: BoxDecoration(color: Colors.white),
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
                left: 181,
                top: 59,
                child: Text(
                  '상점',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 16,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
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
                left: 24,
                top: 302,
                child: Text(
                  '챗바퀴',
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
                top: 325,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 383,
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
                left: 38,
                top: 337,
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
                left: 56,
                top: 402,
                child: Text(
                  '1000',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 325,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 127,
                top: 383,
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
                left: 147,
                top: 402,
                child: Text(
                  '1500',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 124,
                top: 336,
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
                left: 24,
                top: 455,
                child: Text(
                  '물통',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 206,
                top: 478,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 224,
                top: 536,
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
                left: 238,
                top: 555,
                child: Text(
                  '1000',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 269,
                top: 519,
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
                left: 297,
                top: 478,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 319,
                top: 536,
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
                left: 329,
                top: 555,
                child: Text(
                  '1000',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 308,
                top: 491,
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
                left: 24,
                top: 172,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 56,
                top: 249,
                child: Text(
                  '1000',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 191,
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
                top: 230,
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
                left: 24,
                top: 149,
                child: Text(
                  '밥그릇',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 115,
                top: 172,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 127,
                top: 230,
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
                left: 147,
                top: 249,
                child: Text(
                  '1500',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 125,
                top: 191,
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
                left: 24,
                top: 608,
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
                left: 115,
                top: 631,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 123,
                top: 689,
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
                left: 147,
                top: 708,
                child: Text(
                  '1000',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 643,
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
                left: 24,
                top: 631,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 27,
                top: 689,
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
                left: 56,
                top: 708,
                child: Text(
                  '1500',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 35,
                top: 638,
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
                left: 206,
                top: 631,
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 218,
                top: 690,
                child: Text(
                  '이름변경권',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'ABeeZee',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 238,
                top: 708,
                child: Text(
                  '1000',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 10,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 641,
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
              Positioned(
                left: 342,
                top: 99,
                child: Text(
                  '150',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 15,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
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