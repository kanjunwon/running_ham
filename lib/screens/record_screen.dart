// 기록 화면

import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '여기가 진짜 real 기록 화면 (달력)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}