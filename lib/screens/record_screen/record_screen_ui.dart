import 'package:flutter/material.dart';
import 'record_screen_widgets.dart'; // 부품 파일 import

class RecordScreenUI extends StatelessWidget {
  // 로직에서 받아올 데이터들
  final List<int> weeklySteps;
  final List<String> weekDays;
  final Map<int, int> monthlySteps;

  const RecordScreenUI({
    super.key,
    required this.weeklySteps,
    required this.weekDays,
    required this.monthlySteps,
  });

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
              children: const [
                RecordStatItem(label: "오늘 걸음 수", count: "5,102"),
                RecordStatItem(label: "이번 주 걸음 수", count: "18,030"),
                RecordStatItem(label: "이번 달 걸음 수", count: "18,030"),
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
