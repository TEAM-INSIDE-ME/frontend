import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
                            color: sub1,
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
                    child: const Column(
                      children: [
                        Text(
                          'SNS로 간편하게 로그인하세요',
                          style: TextStyle(
                            color: Color.fromARGB(255, 150, 154, 173),
                            fontSize: 12,
                            fontFamily: 'Pretendarad',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        LoginBtn(
                          path: 'kakao',
                          snsName: '카카오',
                          btnColor: Color.fromARGB(255, 253, 239, 171),
                          txtColor: Color.fromARGB(255, 74, 61, 3),
                        ),
                        LoginBtn(
                          path: 'naver',
                          snsName: '네이버',
                          btnColor: Color.fromARGB(255, 211, 237, 200),
                          txtColor: Color.fromARGB(255, 63, 86, 52),
                        ),
                        LoginBtn(
                          path: 'google',
                          snsName: '구글',
                          btnColor: Color.fromARGB(255, 209, 216, 251),
                          txtColor: Color.fromARGB(255, 60, 65, 92),
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

class LoginBtn extends StatelessWidget {
  final String path, snsName;
  final Color btnColor, txtColor;

  const LoginBtn({
    required this.path,
    required this.snsName,
    required this.btnColor,
    required this.txtColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.7124;
    double height = MediaQuery.of(context).size.height * 0.0622;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.2264),
      child: SizedBox(
        width: width,
        height: height,
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
                SizedBox(
                  width: width * 0.0714,
                ),
                Image.asset(
                  'assets/icons/$path.png',
                  height: height * 0.3584,
                  width: width * 0.0607,
                ),
                SizedBox(width: width * 0.225),
                Container(
                  alignment: Alignment.center,
                  width: width * 0.2642,
                  height: height * 0.3207,
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
    print(isInstalled);

    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    final url = Uri.https('kapi.kakao.com', '/v2/user/me');
    final response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer${token.accessToken}'},
    );

    final profileInfo = json.decode(response.body);
    print(profileInfo.toString());

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()));
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
