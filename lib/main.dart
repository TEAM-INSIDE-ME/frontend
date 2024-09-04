import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/scaffolds/main_scaffold.dart';
import 'package:frontend/screens/mainScreen/home_screen.dart';
import 'package:frontend/screens/profileScreen/profile_password_input.dart';
import 'package:frontend/screens/success.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:frontend/utils/user_auth_manager.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // UI 초기화
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: '6580f8850b25238e4d11ec09072d8b96',
    javaScriptAppKey: '256ccb709d41bc1d8d1453141e7600ca',
  );
  Widget initializedScreen = await _tokenStatus();
  runApp(InsideMe(
    initializedScreen: initializedScreen,
  ));
}

Future<Widget> _tokenStatus() async {
  // Refresh Token
  String? refreshToken = await getRefreshToken();

  if (refreshToken != null) {
    bool isRefreshed = await refreshAccessToken();
    if (isRefreshed) {
      // 재발급 성공하면 메인 화면
      return const MainScaffold();
    } else {
      // 실패하면 로그인 화면
      return const LoginScreen();
    }
  } else {
    // 토큰이 없으면 로그인 화면
    return const LoginScreen();
  }
}

class InsideMe extends StatelessWidget {
  Widget initializedScreen;
  InsideMe({
    super.key,
    required this.initializedScreen,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InfoProvider(),
      child: MaterialApp(
        title: 'Inside Me',
        //debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: bg1,
          fontFamily: 'Pretendard',
        ),

        themeMode: ThemeMode.system, // 다크모드 화이트 모드 선택 가능

        home: const LoginScreen(),
      ),
    );
  }
}
