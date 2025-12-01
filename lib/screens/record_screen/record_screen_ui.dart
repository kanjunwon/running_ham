import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'record_screen_widgets.dart';

class RecordScreenUI extends StatelessWidget {
  // 로직에서 받아올 데이터들
  final int displaySteps; // 화면에 크게 보여줄 걸음 수
  final DateTime selectedDate; // 선택된 날짜
  final DateTime focusedDate; // 현재 보고 있는 달력 월

  final List<int> weeklySteps;
  final Map<int, int> monthlySteps;

  // 총합 데이터 받는 변수
  final int weeklyTotal;
  final int monthlyTotal;

  // 콜백 함수들
  final Function(bool) onMonthChanged;
  final Function(int) onDateSelected;

  const RecordScreenUI({
    super.key,
    required this.displaySteps,
    required this.selectedDate,
    required this.focusedDate,
    required this.weeklySteps,
    required this.monthlySteps,
    required this.weeklyTotal,
    required this.monthlyTotal,
    required this.onMonthChanged,
    required this.onDateSelected,
  });

  // 숫자 3자리마다 콤마 찍기 (ex): 12345 -> 12,345))
  String formatSteps(int steps) {
    return NumberFormat('#,###').format(steps);
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

    // 요일 리스트
    final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6), // 연한 핑크 배경
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '기록',
          style: TextStyle(
            color: const Color(0xFF4D3817),
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            fontSize: s(18),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF4D3817)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: s(30), vertical: s(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 통계
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 오늘 걸음 수
                RecordStatItem(
                  label: "오늘 걸음 수",
                  count: formatSteps(displaySteps),
                ),
                RecordStatItem(
                  label: "이번 주 걸음 수",
                  count: formatSteps(weeklyTotal),
                ),
                RecordStatItem(
                  label: "이번 달 걸음 수",
                  count: formatSteps(monthlyTotal),
                ),
              ],
            ),

            SizedBox(height: s(30)),

            // 주간 기록
            const RecordSectionTitle(title: "주간 기록"),
            SizedBox(height: s(15)),
            // 주간 기록 흰색 박스
            Container(
              padding: EdgeInsets.all(s(15)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(s(15)),
              ),
              child: WeeklyChart(weeklySteps: weeklySteps, weekDays: weekDays),
            ),

            SizedBox(height: s(30)),

            // 월간 기록
            const RecordSectionTitle(title: "월간 기록"),
            SizedBox(height: s(15)),
            // 월간 기록 흰색 박스
            Container(
              padding: EdgeInsets.all(s(15)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(s(15)),
              ),
              child: MonthlyCalendar(
                monthlySteps: monthlySteps,
                weekDays: weekDays,
                focusedDate: focusedDate,
                selectedDate: selectedDate,
                onMonthChanged: onMonthChanged,
                onDateSelected: onDateSelected,
              ),
            ),

            SizedBox(height: s(40)),
          ],
        ),
      ),
    );
  }
}
