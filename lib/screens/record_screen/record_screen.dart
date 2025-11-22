import 'package:flutter/material.dart';
import 'record_screen_ui.dart'; // UI 파일 import

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  // 주간 데이터 - 일~토
  final List<int> weeklySteps = [10500, 2000, 6000, 0, 0, 0, 0];
  final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  // 월간 데이터 날짜 걸음수
  final Map<int, int> monthlySteps = {1: 11289, 2: 1639, 3: 5102};

  @override
  Widget build(BuildContext context) {
    // UI 파일만 리턴
    return RecordScreenUI(
      weeklySteps: weeklySteps,
      weekDays: weekDays,
      monthlySteps: monthlySteps,
    );
  }
}
