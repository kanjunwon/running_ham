// 상점 화면

import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '여기가 진짜 real 상점 화면 (아이템)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}