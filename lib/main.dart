import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 패키지
import 'package:running_ham/providers/user_provider.dart'; // UserProvider import
import 'package:running_ham/screens/main_screen/main_screen.dart'; // 메인화면 import
import 'package:firebase_core/firebase_core.dart'; // Firebase
import 'firebase_options.dart'; // Firebase 설정 파일

void main() {
  runApp(
    // 앱 전체에서 Provider 사용 가능하도록 설정
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
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: const Color(0xFFFAF3E6),
      ),
      home: const MainScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart'; // Firebase Core
// import 'firebase_options.dart'; // 설정 파일

// import 'package:running_ham/providers/user_provider.dart';
// // import 'package:running_ham/screens/main_screen/main_screen.dart'; // 이건 이제 안 씀 (직접 호출 X)
// import 'package:running_ham/screens/splash_screen.dart'; // ★ 스플래시 임포트!

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(
//     MultiProvider(
//       providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
//       child: const RunningHamApp(),
//     ),
//   );
// }

// class RunningHamApp extends StatelessWidget {
//   const RunningHamApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '러닝햄',
//       theme: ThemeData(
//         fontFamily: 'Pretendard',
//         scaffoldBackgroundColor: const Color(0xFFFAF3E6),
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }
