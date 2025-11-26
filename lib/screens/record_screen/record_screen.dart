import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:running_ham/providers/user_provider.dart';
import 'record_screen_ui.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  // 날짜 상태 관리
  DateTime _focusedDay = DateTime.now(); // 현재 보고 있는 달력의 기준 월
  DateTime _selectedDay = DateTime.now(); // 클릭해서 선택한 날짜

  // 주간 데이터 계산 함수
  List<int> getWeeklySteps(Map<String, int> history) {
    List<int> steps = [];

    // 오늘이 포함된 주의 일요일 찾기
    // weekday: 1(월)~7(일) → 일요일(7)을 0으로 처리해서 계산
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime sunday = now.subtract(
      Duration(days: currentWeekday == 7 ? 0 : currentWeekday),
    );

    // 일요일부터 토요일까지(7일간) 돌면서 데이터 꺼내기
    for (int i = 0; i < 7; i++) {
      DateTime targetDay = sunday.add(Duration(days: i));
      String key = DateFormat('yyyyMMdd').format(targetDay);

      // 장부에 있으면 그 값, 없으면 0
      steps.add(history[key] ?? 0);
    }
    return steps;
  }

  // 월간 데이터 가져오기
  Map<int, int> getMonthlySteps(Map<String, int> history) {
    Map<int, int> steps = {};

    // 현재 보고 있는 달의 모든 날짜를 찾기 (1일~말일)
    int daysInMonth = DateUtils.getDaysInMonth(
      _focusedDay.year,
      _focusedDay.month,
    );

    for (int i = 1; i <= daysInMonth; i++) {
      String key = DateFormat(
        'yyyyMMdd',
      ).format(DateTime(_focusedDay.year, _focusedDay.month, i));
      // 장부에 기록이 있는 날만 맵에 추가
      if (history.containsKey(key)) {
        steps[i] = history[key]!;
      }
    }
    return steps;
  }

  // 달력 월 변경
  void _changeMonth(bool isNext) {
    setState(() {
      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month + (isNext ? 1 : -1),
      );
    });
  }

  // 날짜 선택
  void _onDaySelected(int day) {
    setState(() {
      _selectedDay = DateTime(_focusedDay.year, _focusedDay.month, day);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final stepHistory = userProvider.stepHistory;

    // 실제 데이터로 계산
    List<int> currentWeeklySteps = getWeeklySteps(stepHistory);
    Map<int, int> currentMonthlySteps = getMonthlySteps(stepHistory);

    // 선택된 날짜의 걸음 수 찾기
    String selectedKey = DateFormat('yyyyMMdd').format(_selectedDay);
    int displaySteps = stepHistory[selectedKey] ?? 0;

    // 통계 계산 (리스트 합계 / 맵 값 합계)
    int weeklyTotal = currentWeeklySteps.fold(
      0,
      (sum, element) => sum + element,
    );
    int monthlyTotal = currentMonthlySteps.values.fold(
      0,
      (sum, element) => sum + element,
    );

    return RecordScreenUI(
      displaySteps: displaySteps,
      selectedDate: _selectedDay,
      focusedDate: _focusedDay,

      weeklySteps: currentWeeklySteps,
      weeklyTotal: weeklyTotal,

      monthlySteps: currentMonthlySteps,
      monthlyTotal: monthlyTotal,

      // 함수 전달
      onMonthChanged: _changeMonth,
      onDateSelected: _onDaySelected,
    );
  }
}
