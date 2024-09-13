import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/custom_icons.dart';
import 'package:frontend/models/colors.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:frontend/screens/mainScreen/home_scaffold.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/screens/success.dart';
import 'package:frontend/utils/login_platforms.dart';
import 'package:frontend/utils/logout_service.dart';
import 'package:frontend/utils/user_auth_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  @override
  void initState() {
    super.initState();
    _loadLoginPlatform();
  }

  // 로그인 플랫폼 조사
  Future<void> _loadLoginPlatform() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _loginPlatform = LoginPlatform.values[prefs.getInt('loginPlatform') ?? 3];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 20 * height,
            left: 0,
            child: Image.asset('assets/images/background/green_bg.png'),
          ),
          Positioned(
            top: 30 * height,
            right: 0,
            child: Image.asset('assets/images/background/red_bg.png'),
          ),
          Positioned(
            top: 180 * height,
            left: 0,
            child: Image.asset('assets/images/background/blue_bg.png'),
          ),
          Positioned(
            top: 280 * height,
            right: 0,
            child: Image.asset('assets/images/background/yellow_bg.png'),
          ),
          Center(
            child: Column(
              children: [
                Flexible(
                  flex: 151,
                  child: Container(),
                ),
                Flexible(
                  flex: 82,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 22,
                        fit: FlexFit.tight,
                        child: Text(
                          "내 안의 이야기,나를 찾는 곳",
                          style: TextStyle(
                            color: sub2,
                            fontWeight: FontWeight.w700,
                            fontSize: 18 * height,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 12,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 48,
                        fit: FlexFit.tight,
                        child: Text(
                          "Inside Me",
                          style: TextStyle(
                            color: sub2,
                            fontFamily: 'Marine',
                            fontWeight: FontWeight.w700,
                            fontSize: 42 * height,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 325,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 40,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 190,
                        fit: FlexFit.tight,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 190 * height,
                          width: 190 * width,
                        ),
                      ),
                      Flexible(
                        flex: 95,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 213,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Text(
                        'SNS로 간편하게 로그인하세요',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 150, 154, 173),
                          fontSize: 12 * height,
                          fontFamily: 'Pretendarad',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      LoginBtn(
                        onPressed: () async {
                          Future<int> statusCode = signInWithKakao(context);
                          print("statusCode: $statusCode");
                          if (statusCode == 404) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false,
                            );
                          } else if (statusCode == 200) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScaffold()),
                              (route) => false,
                            );
                          }
                        },
                        snsName: '카카오',
                        iconData: CustomIcons.kakaotalk_icon,
                        btnColor: const Color.fromARGB(255, 253, 239, 171),
                        txtColor: const Color.fromARGB(255, 74, 61, 3),
                      ),
                      LoginBtn(
                        onPressed: () {
                          signInWithNaver(context);
                        },
                        snsName: '네이버',
                        iconData: CustomIcons.naver_icon,
                        btnColor: const Color.fromARGB(255, 211, 237, 200),
                        txtColor: const Color.fromARGB(255, 63, 86, 52),
                      ),
                      LoginBtn(
                        onPressed: () {
                          signInWithGoogle(context);
                        },
                        snsName: '구글',
                        iconData: CustomIcons.google_icon,
                        btnColor: const Color.fromARGB(255, 209, 216, 251),
                        txtColor: const Color.fromARGB(255, 60, 65, 92),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 68,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<int> signInWithKakao(BuildContext context) async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      print(isInstalled);

      // 카카오톡 설치되어있으면 앱으로 로그인
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url =
          Uri.parse('https://0a06-211-243-13-74.ngrok-free.app/api/user/kakao');

      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
        if (token.refreshToken != null) 'X-Refresh-Token': token.refreshToken!,
      };

      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        User user = await UserApi.instance.me();
        print('${user.kakaoAccount}');
        print('카카오 로그인 성공!');
        print(response.statusCode);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SuccessScreen()));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SuccessScreen()));

        return response.statusCode;
      } else {
        print('서버 응답 오류: ${response.statusCode}');
        return response.statusCode;
      }
    } catch (error) {
      print("카카오톡 로그인 실패 $error");
      return 500;
    }
  }

  Future<void> signInWithNaver(BuildContext context) async {
    NaverLoginResult result = await FlutterNaverLogin.logIn();

    NaverAccessToken naverAccessToken =
        await FlutterNaverLogin.currentAccessToken;

    //setState(() {
    var accesToken = naverAccessToken.accessToken;
    var tokenType = naverAccessToken.tokenType;
    //});

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()));
  }

  Future<void> naverlogout() async {
    try {
      await FlutterNaverLogin.logOutAndDeleteToken();
    } catch (error) {}
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print("name = ${googleUser.displayName}");
      print("email = ${googleUser.email}");
      print("id = ${googleUser.id}");
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()));
  }

  void signOut() async {
    await SignOutService.signOut(_loginPlatform);
    setState(() {
      _loginPlatform = LoginPlatform.none;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginPlatform');
  }
}
