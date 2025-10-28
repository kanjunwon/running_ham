import 'package:flutter/material.dart';

void main() {
  runApp(const RunningHamApp());
}

class RunningHamApp extends StatelessWidget {
  const RunningHamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '러닝햄',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // (나중에) 다크모드 대신 라이트모드로 고정할 수도 있어
        // themeMode: ThemeMode.light, 
      ),
      home: const MainPage(), // <--- 아까 Scaffold에서 MainPage로 변경!
    );
  }
}

// '상태'가 있는 메인 페이지 (StatefulWidget)
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 0: 메인, 1: 기록, 2: 상점
  int _selectedIndex = 0; 

  // 탭에 따라 보여줄 3개의 '임시' 화면 위젯 리스트
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('여기가 메인 화면 (햄스터 보임)', style: TextStyle(fontSize: 20))),
    Center(child: Text('여기가 기록 화면 (달력 보임)', style: TextStyle(fontSize: 20))),
    Center(child: Text('여기가 상점 화면 (아이템 보임)', style: TextStyle(fontSize: 20))),
  ];

  // 탭을 눌렀을 때 _selectedIndex를 바꾸는 함수
  void _onItemTapped(int index) {
    setState(() { // setState를 해야 화면이 바뀜!
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 상단 앱 바 (제목)
      appBar: AppBar(
        title: const Text('러닝햄'),
        backgroundColor: Colors.amber, // (임시) 색깔
      ),
      // 2. 메인 컨텐츠 (선택된 탭에 따라 바뀜)
      body: _widgetOptions.elementAt(_selectedIndex),
      
      // 3. 하단 탭 바
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '메인',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: '상점',
          ),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 탭
        selectedItemColor: Colors.amber[800], // 눌렀을 때 색깔
        onTap: _onItemTapped, // 탭 눌렀을 때 실행할 함수
      ),
    );
  }
}