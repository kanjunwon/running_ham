import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  // [테스트용 데이터] (일, 월, 화, 수, 목, 금, 토)
  final List<int> weeklySteps = [10500, 2000, 6000, 0, 0, 0, 0]; 
  final List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            // 1. 상단 통계
            _buildTopStats(),

            const SizedBox(height: 30),

            // 2. 주간 기록 (그래프 수정됨!)
            _buildSectionTitle("주간 기록"),
            const SizedBox(height: 15),
            _buildWeeklyChart(), // <--- 여기가 핵심!

            const SizedBox(height: 30),

            // 3. 월간 기록
            _buildSectionTitle("월간 기록"),
            const SizedBox(height: 15),
            _buildMonthlyCalendar(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- [위젯 조립 공장] ---

  Widget _buildTopStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem("오늘 걸음 수", "5,102"),
        _buildStatItem("이번 주 걸음 수", "18,030"),
        _buildStatItem("이번 달 걸음 수", "18,030"),
      ],
    );
  }

  Widget _buildStatItem(String label, String count) {
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
            fontFamily: 'Recipekorea',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
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

  // [핵심 수정] 막대 색상 결정 함수
  Color _getBarColor(int steps) {
    if (steps >= 10000) {
      return const Color(0xFFE45151); // 10,000보 달성 (진한 빨강)
    } else if (steps >= 5000) {
      return const Color(0xFFFD8F8F); // 5,000보 달성 (중간 분홍)
    } else {
      return const Color(0xFFFFC0C0); // 실패/조금 걸음 (연한 분홍 - 0 포함)
    }
  }

  // [핵심 수정] 주간 차트 위젯 (Y축 라벨 추가)
  Widget _buildWeeklyChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 250,
      child: Row(
        children: [
          // 1. 왼쪽 Y축 (수치 라벨)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위-중간-아래 정렬
            crossAxisAlignment: CrossAxisAlignment.end, // 오른쪽 정렬
            children: const [
              Text('10,000', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('5,000', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('0', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          
          const SizedBox(width: 15), // 라벨과 그래프 사이 간격

          // 2. 오른쪽 그래프 (막대기들)
          Expanded(
            child: LayoutBuilder( // 부모 크기에 맞춰서 높이 계산
              builder: (context, constraints) {
                // 차트 영역의 실제 높이 (요일 글자 높이 제외)
                final chartHeight = constraints.maxHeight - 20; 

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    // 막대 높이 계산 (10000보가 100% 기준)
                    double heightFactor = weeklySteps[index] / 10000;
                    if (heightFactor > 1.0) heightFactor = 1.0; // 그래프 뚫고 나가지 않게

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // 막대기
                        Container(
                          width: 18, // 막대 두께
                          height: chartHeight * heightFactor, // 비율에 따른 높이
                          decoration: BoxDecoration(
                            color: _getBarColor(weeklySteps[index]), // 색상 함수 적용!
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 1), // 막대와 요일 사이 간격
                        // 요일
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

  // 3. 월간 달력 위젯
  Widget _buildMonthlyCalendar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 달력 헤더
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
                .map((day) => Text(
                      day,
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          const Divider(), 

          // 날짜 그리드
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 31 + 3, // 빈칸 + 31일
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              if (index < 3) return const SizedBox();
              
              int day = index - 2;
              // [테스트용] 1, 2, 3일에만 기록
              bool hasRecord = (day >= 1 && day <= 3);
              int steps = hasRecord ? (day == 1 ? 11289 : (day == 2 ? 1639 : 5102)) : 0;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: hasRecord ? const Color(0xFFE45151).withOpacity(day == 1 ? 1.0 : 0.4) : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$day",
                      style: TextStyle(
                        color: hasRecord ? Colors.white : Colors.black,
                        fontWeight: hasRecord ? FontWeight.bold : FontWeight.normal,
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
      ),
    );
  }
}