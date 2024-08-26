import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/custom_icons.dart';
import 'package:frontend/models/colors.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:frontend/screens/success.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                        path: 'kakao',
                        snsName: '카카오',
                        iconData: CustomIcons.kakaotalk_icon,
                        btnColor: const Color.fromARGB(255, 253, 239, 171),
                        txtColor: const Color.fromARGB(255, 74, 61, 3),
                      ),
                      LoginBtn(
                        path: 'naver',
                        snsName: '네이버',
                        iconData: CustomIcons.naver_icon,
                        btnColor: const Color.fromARGB(255, 211, 237, 200),
                        txtColor: const Color.fromARGB(255, 63, 86, 52),
                      ),
                      LoginBtn(
                        path: 'google',
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
}

Future<void> signInWithKakao(BuildContext context) async {
  try {
    bool isInstalled = await isKakaoTalkInstalled();
    //print(isInstalled);

    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    final url = Uri.parse('http://10.0.2.2:8080/api/user/kakao');

    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
      if (token.refreshToken != null) 'X-Refresh-Token': token.refreshToken!,
    };

    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      User user = await UserApi.instance.me();
      print('${user.kakaoAccount}');
      print('카카오 로그인 성공!');

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SuccessScreen()));
    } else {
      print('서버 응답 오류: ${response.statusCode}');
    }
  } catch (error) {
    print("카카오톡 로그인 실패 $error");
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

  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SuccessScreen()));
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

  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SuccessScreen()));
}
