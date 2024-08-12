import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileScreen/profile_password_input.dart';
import 'package:frontend/screens/success.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

void main() {
  KakaoSdk.init(
    nativeAppKey: '6580f8850b25238e4d11ec09072d8b96',
    javaScriptAppKey: '256ccb709d41bc1d8d1453141e7600ca',
  );
  runApp(const InsideMe());
}

class InsideMe extends StatelessWidget {
  const InsideMe({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InfoProvider(),
      child: MaterialApp(
        title: 'Inside Me',
        theme: ThemeData(
          scaffoldBackgroundColor: bg,
          fontFamily: 'Pretendard',
        ),

        themeMode: ThemeMode.system, // 다크모드 화이트 모드 선택 가능
        //home: const ProfileScreen(),
        home: const ProfileScreen(),
      ),
    );
  }
}
