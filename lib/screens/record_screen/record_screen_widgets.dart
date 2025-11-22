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
            fontFamily: 'Recipekorea', // 폰트 있으면 적용
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

  // 막대 색상 결정 함수
  Color _getBarColor(int steps) {
    if (steps >= 10000) {
      return const Color(0xFFE45151); // 10,000보 (진한 빨강)
    } else if (steps >= 5000) {
      return const Color(0xFFFD8F8F); // 5,000보 (중간 분홍)
    } else {
      return const Color(0xFFFFC0C0); // 실패 (연한 분홍)
    }
  }

  @override
  Widget build(BuildContext context) {
    // 박스 제거됨 (SizedBox로 높이만 고정)
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
          const SizedBox(width: 10),
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
  final Map<int, int> monthlySteps; // 날짜 걸음수 데이터
  final List<String> weekDays;

  const MonthlyCalendar({
    super.key,
    required this.monthlySteps,
    required this.weekDays,
  });

  @override
  Widget build(BuildContext context) {
    // 박스 제거됨 (Column 바로 시작)
    return Column(
      children: [
        // 헤더
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chevron_left, color: Colors.grey),
            const SizedBox(width: 10),
            const Text(
              "2025.10",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE45151),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right, color: Colors.grey),
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
          itemCount: 31 + 3,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            if (index < 3) return const SizedBox();

            int day = index - 2;
            // 데이터가 있으면 가져오고, 없으면 0
            int steps = monthlySteps[day] ?? 0;
            bool hasRecord = steps > 0;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: hasRecord
                        ? const Color(
                            0xFFE45151,
                          ).withOpacity(day == 1 ? 1.0 : 0.4)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$day",
                    style: TextStyle(
                      color: hasRecord ? Colors.white : Colors.black,
                      fontWeight: hasRecord
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
            );
          },
        ),
      ],
    );
  }
}
