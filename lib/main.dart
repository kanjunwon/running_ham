// 앱 시작 대문

import 'package:flutter/material.dart';
import 'package:running_ham/screens/main_screen.dart';    // 메인 페이지
import 'package:running_ham/screens/record_screen.dart';  // 기록 페이지
import 'package:running_ham/screens/store_screen.dart';   // 상점 페이지

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
        // 다크모드 대신 라이트모드로 고정 가능
        // themeMode: ThemeMode.light, 
      ),
      home: const MainPage(),
    );
  }
}

// '상태'가 있는 메인 페이지
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 0: 메인, 1: 기록, 2: 상점
  int _selectedIndex = 0; 

  // 탭에 따라 보여줄 3개의 화면 위젯 리스트
static const List<Widget> _widgetOptions = <Widget>[
    MainScreen(),   // 0번 탭
    RecordScreen(), // 1번 탭
    StoreScreen(),  // 2번 탭
  ];

  // 탭을 눌렀을 때 _selectedIndex를 바꾸는 함수
  void _onItemTapped(int index) {
    setState(() { // setState를 해야 화면이 바뀜
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 메인 컨텐츠 (선택된 탭에 따라 바뀜)
      body: _widgetOptions.elementAt(_selectedIndex),
      
      // 하단 탭 바
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