// 기록 화면

import 'package:flutter/material.dart'; // <--- 1. 이거 추가!

class RecordScreen extends StatelessWidget { // <--- 2. 이름 추가!
  const RecordScreen({super.key}); // (이것도 추가해주면 더 좋아)
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
                  '기록',
                  style: TextStyle(
                    color: const Color(0xFF4D3817),
                    fontSize: 16,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 113,
                child: Text(
                  '오늘 걸음 수',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 43,
                top: 138,
                child: Text(
                  '5,102',
                  style: TextStyle(
                    color: const Color(0xFFE45151),
                    fontSize: 16,
                    fontFamily: 'Recipekorea',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 157,
                top: 113,
                child: Text(
                  '이번 주 걸음 수',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 161,
                top: 138,
                child: Text(
                  '18,030',
                  style: TextStyle(
                    color: const Color(0xFFE45151),
                    fontSize: 16,
                    fontFamily: 'Recipekorea',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 278,
                top: 113,
                child: Text(
                  '이번 달 걸음 수',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 283,
                top: 138,
                child: Text(
                  '18,030',
                  style: TextStyle(
                    color: const Color(0xFFE45151),
                    fontSize: 16,
                    fontFamily: 'Recipekorea',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 223,
                child: Container(
                  width: 350,
                  height: 260,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 253,
                child: Container(
                  width: 20,
                  height: 192,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE45151),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 129,
                top: 416,
                child: Container(
                  width: 20,
                  height: 29,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFC0C0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 165,
                top: 337,
                child: Container(
                  width: 20,
                  height: 108,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFC8F8F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 204,
                top: 445,
                child: Container(
                  width: 19,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 241,
                top: 444.14,
                child: Container(
                  width: 19,
                  height: 0.86,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 278,
                top: 444.14,
                child: Container(
                  width: 19,
                  height: 0.86,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 315,
                top: 445,
                child: Container(
                  width: 19,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 133,
                top: 449,
                child: Text(
                  'M',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 173,
                top: 449,
                child: Text(
                  'T',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 209,
                top: 449,
                child: Text(
                  'W',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 250,
                top: 449,
                child: Text(
                  'T',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 286,
                top: 449,
                child: Text(
                  'F',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 449,
                child: Text(
                  'S',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 322,
                top: 449,
                child: Text(
                  'S',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 64,
                top: 436,
                child: SizedBox(
                  width: 18,
                  height: 9,
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: const Color(0xFF6A6A6A),
                      fontSize: 12,
                      fontFamily: 'AppleSDGothicNeoM00',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 342,
                child: SizedBox(
                  width: 40,
                  height: 13,
                  child: Text(
                    '5.000',
                    style: TextStyle(
                      color: const Color(0xFF6A6A6A),
                      fontSize: 12,
                      fontFamily: 'AppleSDGothicNeoM00',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 41,
                top: 253,
                child: SizedBox(
                  width: 48,
                  height: 11,
                  child: Text(
                    '10.000',
                    style: TextStyle(
                      color: const Color(0xFF6A6A6A),
                      fontSize: 12,
                      fontFamily: 'AppleSDGothicNeoM00',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 195,
                child: Container(
                  width: 78,
                  height: 28,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFDDDD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 37,
                top: 200,
                child: Text(
                  '주간 기록',
                  style: TextStyle(
                    color: const Color(0xFFE45151),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 620,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE45151),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 87,
                top: 620,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFC0C0),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 134,
                top: 620,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFC8F8F),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 644,
                child: Text(
                  '11,289',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 8,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 644,
                child: Text(
                  '1,639',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 8,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 136,
                top: 644,
                child: Text(
                  '5,102',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 8,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 577,
                child: Text(
                  'M',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 142,
                top: 577,
                child: Text(
                  'T',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 577,
                child: Text(
                  'W',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 238,
                top: 577,
                child: Text(
                  'T',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 286,
                top: 577,
                child: Text(
                  'F',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 577,
                child: Text(
                  'S',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 331,
                top: 577,
                child: Text(
                  'S',
                  style: TextStyle(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoEB00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 331,
                top: 623,
                child: Text(
                  '7',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 328,
                top: 658,
                child: Text(
                  '14',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 327,
                top: 734,
                child: Text(
                  '28',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 329,
                top: 697,
                child: Text(
                  '21',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 158,
                top: 540,
                child: Opacity(
                  opacity: 0.90,
                  child: Text(
                    '2025.10',
                    style: TextStyle(
                      color: const Color(0xFFE45151),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 48,
                top: 658,
                child: Text(
                  '8',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 46,
                top: 697,
                child: Text(
                  '15',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 734,
                child: Text(
                  '22',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 44,
                top: 771,
                child: Text(
                  '29',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 49,
                top: 623,
                child: Text(
                  '1',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 95,
                top: 658,
                child: Text(
                  '9',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 92,
                top: 734,
                child: Text(
                  '23',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 91,
                top: 771,
                child: Text(
                  '30',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 93,
                top: 697,
                child: Text(
                  '16',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 96,
                top: 623,
                child: Text(
                  '2',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 140,
                top: 658,
                child: Text(
                  '10',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 139,
                top: 734,
                child: Text(
                  '24',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 140,
                top: 697,
                child: Text(
                  '17',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 143,
                top: 623,
                child: Text(
                  '3',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 281,
                top: 658,
                child: Text(
                  '13',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 280,
                top: 734,
                child: Text(
                  '27',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 279,
                top: 697,
                child: Text(
                  '20',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 283,
                top: 623,
                child: Text(
                  '6',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 658,
                child: Text(
                  '11',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 186,
                top: 734,
                child: Text(
                  '25',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 187,
                top: 697,
                child: Text(
                  '18',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 189,
                top: 623,
                child: Text(
                  '4',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 233,
                top: 658,
                child: Text(
                  '12',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 232,
                top: 734,
                child: Text(
                  '26',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 233,
                top: 697,
                child: Text(
                  '19',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 236,
                top: 623,
                child: Text(
                  '5',
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontFamily: 'AppleSDGothicNeoM00',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: 496,
                child: Container(
                  width: 78,
                  height: 28,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFDDDD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 37,
                top: 501,
                child: Text(
                  '월간 기록',
                  style: TextStyle(
                    color: const Color(0xFFE45151),
                    fontSize: 12,
                    fontFamily: 'AppleSDGothicNeoB00',
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