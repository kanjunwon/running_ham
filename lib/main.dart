import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 패키지
import 'package:running_ham/providers/user_provider.dart'; // UserProvider import
// 메인화면 import
import 'package:running_ham/screens/splash_screen/splash_screen.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const RunningHamApp(),
    ),
  );
}

class RunningHamApp extends StatelessWidget {
  const RunningHamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '러닝햄',
      debugShowCheckedModeBanner: false, // 오른쪽 위 Debug 띠 제거
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: const Color(0xFFFAF3E6),
      ),
      // 실행 시, 스플래시 화면부터 시작
      home: const SplashScreen(),
    );
  }
}
