import 'package:flutter/material.dart';

// 상단 통계 아이템
class RecordStatItem extends StatelessWidget {
  final String label;
  final String count;

  const RecordStatItem({super.key, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
        ),
        const SizedBox(height: 5),
        Text(
          count,
          style: const TextStyle(
            color: Color(0xFFE45151),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pretendard',
          ),
        ),
      ],
    );
  }
}

// 섹션 제목
class RecordSectionTitle extends StatelessWidget {
  final String title;

  const RecordSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDDDD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFE45151),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

// 주간 차트
class WeeklyChart extends StatelessWidget {
  final List<int> weeklySteps;
  final List<String> weekDays;

  const WeeklyChart({
    super.key,
    required this.weeklySteps,
    required this.weekDays,
  });

  Color _getBarColor(int steps) {
    if (steps >= 10000) {
      return const Color(0xFFE45151);
    } else if (steps >= 5000) {
      return const Color(0xFFFD8F8F);
    } else {
      return const Color(0xFFFFC0C0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(
        children: [
          // 왼쪽 Y축
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                '10,000',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text('5,000', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('0', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 15),

          // 오른쪽 그래프
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartHeight = constraints.maxHeight - 40;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    double heightFactor = weeklySteps[index] / 10000;
                    if (heightFactor > 1.0) heightFactor = 1.0;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 18,
                          height: chartHeight * heightFactor,
                          decoration: BoxDecoration(
                            color: _getBarColor(weeklySteps[index]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          weekDays[index],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 월간 달력
class MonthlyCalendar extends StatelessWidget {
  final Map<int, int> monthlySteps;
  final List<String> weekDays;
  final DateTime focusedDate; // 현재 보고 있는 달
  final DateTime selectedDate; // 선택된 날짜
  final Function(bool) onMonthChanged; // 달력 넘기기 콜백
  final Function(int) onDateSelected; // 날짜 선택 콜백

  const MonthlyCalendar({
    super.key,
    required this.monthlySteps,
    required this.weekDays,
    required this.focusedDate,
    required this.selectedDate,
    required this.onMonthChanged,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // 해당 달의 마지막 날짜 계산
    final daysInMonth = DateUtils.getDaysInMonth(
      focusedDate.year,
      focusedDate.month,
    );
    // 해당 달의 1일이 무슨 요일인지 계산 (월=1 ... 일=7 -> 일=0으로 보정 필요)
    final firstDayWeekday = DateTime(
      focusedDate.year,
      focusedDate.month,
      1,
    ).weekday;
    // 일요일(7)을 0으로, 월(1)을 1로... 이렇게 보정
    final startOffset = firstDayWeekday == 7 ? 0 : firstDayWeekday;

    return Column(
      children: [
        // 헤더
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.grey),
              onPressed: () => onMonthChanged(false), // 이전 달
            ),
            const SizedBox(width: 10),
            Text(
              "${focusedDate.year}.${focusedDate.month.toString().padLeft(2, '0')}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE45151),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.grey),
              onPressed: () => onMonthChanged(true), // 다음 달
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 요일 헤더
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDays
              .map(
                (day) => Text(
                  day,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 10),
        const Divider(),

        // 날짜 그리드
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: daysInMonth + startOffset, // 빈칸 + 날짜 수
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            // 앞부분 빈칸 처리
            if (index < startOffset) return const SizedBox();

            int day = index - startOffset + 1;
            int steps = monthlySteps[day] ?? 0;
            bool hasRecord = steps > 0;

            // 선택된 날짜인지 확인 (연/월/일 모두 같아야 함)
            bool isSelected =
                selectedDate.year == focusedDate.year &&
                selectedDate.month == focusedDate.month &&
                selectedDate.day == day;

            return GestureDetector(
              onTap: () => onDateSelected(day),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      // 선택되면 테두리, 기록 있으면 배경색
                      color: hasRecord
                          ? const Color(
                              0xFFE45151,
                            ).withOpacity(day % 2 == 0 ? 0.4 : 1.0)
                          : Colors.transparent,
                      border: isSelected
                          ? Border.all(color: const Color(0xFF4D3817), width: 2)
                          : null,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$day",
                      style: TextStyle(
                        color: hasRecord ? Colors.white : Colors.black,
                        fontWeight: isSelected || hasRecord
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (hasRecord)
                    Text(
                      "$steps",
                      style: const TextStyle(fontSize: 8, color: Colors.grey),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
