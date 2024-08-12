import 'dart:io';

import 'package:flutter/material.dart';
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
            top: 20,
            left: 0,
            child: Image.asset('assets/images/green_bg.png'),
          ),
          Positioned(
            top: 30,
            right: 0,
            child: Image.asset('assets/images/red_bg.png'),
          ),
          Positioned(
            top: 180,
            left: 0,
            child: Image.asset('assets/images/blue_bg.png'),
          ),
          Positioned(
            top: 280,
            right: 0,
            child: Image.asset('assets/images/yellow_bg.png'),
          ),
          Center(
            child: Column(
              children: [
                Flexible(
                  flex: 1772,
                  child: Container(),
                ),
                Flexible(
                  flex: 962,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 2682,
                        fit: FlexFit.tight,
                        child: Text(
                          "내 안의 이야기,나를 찾는 곳",
                          style: TextStyle(
                            color: sub2,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 833,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 5853,
                        fit: FlexFit.tight,
                        child: Text(
                          "Inside Me",
                          style: TextStyle(
                            color: sub2,
                            fontFamily: 'Marine',
                            fontWeight: FontWeight.w700,
                            fontSize: 42,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3814,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1230,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 5846,
                        fit: FlexFit.tight,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 190,
                          width: 190,
                        ),
                      ),
                      Flexible(
                        flex: 2923,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2500,
                  fit: FlexFit.tight,
                  child: Container(
                    child: Column(
                      children: [
                        const Text(
                          'SNS로 간편하게 로그인하세요',
                          style: TextStyle(
                            color: Color.fromARGB(255, 150, 154, 173),
                            fontSize: 12,
                            fontFamily: 'Pretendarad',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        LoginBtn1(
                          path: 'kakao',
                          snsName: '카카오',
                          iconData: CustomIcons.kakaotalk_icon,
                          btnColor: const Color.fromARGB(255, 253, 239, 171),
                          txtColor: const Color.fromARGB(255, 74, 61, 3),
                        ),
                        LoginBtn1(
                          path: 'naver',
                          snsName: '네이버',
                          iconData: CustomIcons.naver_icon,
                          btnColor: const Color.fromARGB(255, 211, 237, 200),
                          txtColor: const Color.fromARGB(255, 63, 86, 52),
                        ),
                        LoginBtn1(
                          path: 'google',
                          snsName: '구글',
                          iconData: CustomIcons.google_icon,
                          btnColor: const Color.fromARGB(255, 209, 216, 251),
                          txtColor: const Color.fromARGB(255, 60, 65, 92),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 798,
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

class LoginBtn1 extends StatelessWidget {
  final String path, snsName;
  final Color btnColor, txtColor;
  IconData iconData;

  LoginBtn1({
    super.key,
    required this.path,
    required this.snsName,
    required this.btnColor,
    required this.txtColor,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Padding(
      padding: EdgeInsets.only(top: 12 * height),
      child: TextButton.icon(
        onPressed: () {
          path == 'kakao'
              ? signInWithKakao(context)
              : path == 'naver'
                  ? signInWithNaver(context)
                  : path == 'google'
                      ? signInWithGoogle(context)
                      : null;
        },
        icon: Icon(
          iconData,
          size: 17 * width,
          color: txtColor,
        ),
        label: Padding(
          padding: EdgeInsets.only(
            left: 63 * width,
          ),
          child: Text(
            '$snsName 로그인',
            style: TextStyle(
              color: txtColor,
              fontSize: 13,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: btnColor,
          alignment: Alignment.centerLeft,
          fixedSize: Size(280 * width, 53 * height),
          padding: EdgeInsets.only(left: 20 * width),
        ),
      ),
    );
  }
}

class LoginBtn extends StatelessWidget {
  final String path, snsName;
  final Color btnColor, txtColor;
  IconData iconData;

  LoginBtn({
    required this.path,
    required this.snsName,
    required this.iconData,
    required this.btnColor,
    required this.txtColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Padding(
      padding: EdgeInsets.only(top: 12 * height),
      child: SizedBox(
        width: 280 * width,
        height: 53 * height,
        child: InkWell(
          onTap: () {
            path == 'kakao'
                ? signInWithKakao(context)
                : path == 'naver'
                    ? signInWithNaver(context)
                    : path == 'google'
                        ? signInWithGoogle(context)
                        : null;
          },
          borderRadius: BorderRadius.circular(100),
          child: Ink(
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                SizedBox(width: 20 * width),
                Icon(
                  iconData,
                  color: txtColor,
                  size: 17,
                ),
                SizedBox(width: 63 * width),
                Container(
                  alignment: Alignment.center,
                  width: 74 * width,
                  height: 17 * height,
                  child: Text(
                    '$snsName 로그인',
                    style: TextStyle(
                      color: txtColor,
                      fontSize: 13,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
