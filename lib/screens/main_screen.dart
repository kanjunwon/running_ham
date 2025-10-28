// 메인 페이지

import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold는 페이지 1장
    return Scaffold( 
      body: Center(
        child: Text(
          '여기가 진짜 real 메인 화면 (햄스터 보임)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}