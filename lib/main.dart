import 'package:flutter/material.dart';
import 'package:running_ham/screens/main_screen/main_screen.dart'; // 메인화면 import
import 'package:firebase_core/firebase_core.dart'; // Firebase
import 'firebase_options.dart'; // Firebase 설정 파일

void main() async {
  // Flutter가 Firebase를 기다리도록 설정
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // Firebase 프로젝트 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const RunningHamApp());
}

class RunningHamApp extends StatelessWidget {
  const RunningHamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '러닝햄',
      theme: ThemeData(
         // 나중에 피그마 디자인에 맞춰서 수정해야함 (다크 or 라이트)
         // brightness: Brightness.light, 
      ),
      
      home: MainScreen(), 
    );
  }
}