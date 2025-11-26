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
    // 요일 리스트
    final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Scaffold(
      backgroundColor: Colors.white, // 배경 흰색
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '기록',
          style: TextStyle(
            color: Color(0xFF4D3817),
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 통계
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 선택한 날짜 데이터
                RecordStatItem(
                  label: "${selectedDate.month}월 ${selectedDate.day}일",
                  count: formatSteps(displaySteps),
                ),
                RecordStatItem(label: "이번 주", count: formatSteps(weeklyTotal)),
                RecordStatItem(label: "이번 달", count: formatSteps(monthlyTotal)),
              ],
            ),

            const SizedBox(height: 30),

            // 주간 기록
            const RecordSectionTitle(title: "주간 기록"),
            const SizedBox(height: 15),
            // 부품 호출
            WeeklyChart(weeklySteps: weeklySteps, weekDays: weekDays),

            const SizedBox(height: 30),

            // 월간 기록
            const RecordSectionTitle(title: "월간 기록"),
            const SizedBox(height: 15),
            // 부품 호출
            MonthlyCalendar(
              monthlySteps: monthlySteps,
              weekDays: weekDays,
              focusedDate: focusedDate,
              selectedDate: selectedDate,
              onMonthChanged: onMonthChanged,
              onDateSelected: onDateSelected,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
