import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'record_screen_widgets.dart';

class RecordScreenUI extends StatelessWidget {
  // 로직에서 받아올 데이터들
  final int todaySteps; // 오늘 걸음 수
  final List<int> weeklySteps;
  final List<String> weekDays;
  final Map<int, int> monthlySteps;

  const RecordScreenUI({
    super.key,
    required this.todaySteps,
    required this.weeklySteps,
    required this.weekDays,
    required this.monthlySteps,
  });

  // 숫자 3자리마다 콤마 찍기 (ex): 10000 -> 10,000)
  String formatSteps(int steps) {
    return NumberFormat('#,###').format(steps);
  }

  @override
  Widget build(BuildContext context) {
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
                // 걸음 수 연결
                RecordStatItem(
                  label: "오늘 걸음 수",
                  count: formatSteps(todaySteps),
                ),
                // (주간/월간은 아직 가짜 데이터 유지)
                const RecordStatItem(label: "이번 주 걸음 수", count: "9,030"),
                const RecordStatItem(label: "이번 달 걸음 수", count: "18,030"),
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
            MonthlyCalendar(monthlySteps: monthlySteps, weekDays: weekDays),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
