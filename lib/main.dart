import 'package:flutter/material.dart';
import 'package:running_ham/screens/main_screen.dart'; // [중요!] 우리 메인 화면 불러오기

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
         // 나중에 피그마 디자인에 맞춰서 흰색 배경(라이트 모드)으로 고정하자
         // brightness: Brightness.light, 
      ),
      
      // [핵심!] 뼈대 다 없애고, 'MainScreen'을 유일한 홈으로 지정!
      home: MainScreen(), 
    );
  }
}