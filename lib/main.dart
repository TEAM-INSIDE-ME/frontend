import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/login_screen.dart';

void main() {
  runApp(const InsideMe());
}

class InsideMe extends StatelessWidget {
  const InsideMe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inside Me',
      theme: ThemeData(
        scaffoldBackgroundColor: bg,
        fontFamily: 'Pretendard',
      ),

      themeMode: ThemeMode.system, // 다크모드 화이트 모드 선택 가능
      home: const LoginScreen(),
    );
  }
}
