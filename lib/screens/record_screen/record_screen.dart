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

  // 임시 데이터 생성 로직
  List<int> getWeeklySteps() {
    List<int> steps = [0, 0, 0, 0, 0, 0, 0]; // 일~토
    // (테스트용 데이터)
    return [3450, 7890, 12300, 4560, 9800, 15000, 6700];
  }

  Map<int, int> getMonthlySteps() {
    // (테스트용 데이터)
    if (_focusedDay.month == 11) {
      return {1: 3000, 5: 10000, 15: 5230};
    }
    return {1: 11289, 2: 1639, 3: 5102};
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
    final int realTodaySteps = userProvider.todaySteps;

    // 이번 주 데이터 가져오기
    List<int> currentWeeklySteps = getWeeklySteps();
    int todayWeekdayIndex = DateTime.now().weekday % 7;
    currentWeeklySteps[todayWeekdayIndex] = realTodaySteps;

    // 이번 달 데이터 가져오기
    Map<int, int> currentMonthlySteps = getMonthlySteps();
    if (_focusedDay.year == DateTime.now().year &&
        _focusedDay.month == DateTime.now().month) {
      currentMonthlySteps[DateTime.now().day] = realTodaySteps;
    }

    // 선택된 날짜의 걸음 수 찾기
    int displaySteps = 0;
    if (_selectedDay.year == DateTime.now().year &&
        _selectedDay.month == DateTime.now().month &&
        _selectedDay.day == DateTime.now().day) {
      displaySteps = realTodaySteps;
    } else {
      displaySteps = currentMonthlySteps[_selectedDay.day] ?? 0;
    }

    // 통계 계산
    int weeklyTotal = currentWeeklySteps.reduce((a, b) => a + b);
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
