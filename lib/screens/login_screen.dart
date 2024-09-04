import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/custom_icons.dart';
import 'package:frontend/models/colors.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:frontend/scaffolds/main_scaffold.dart';
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

  // 로그인 플랫폼 저장
  Future<void> _saveLoginPlatForm(LoginPlatform platform) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('loginPlatform', platform.index);
  }

  Future<int> socialLogin(String? socialId) async {
    var url =
        Uri.parse('https://01c6-211-243-13-74.ngrok-free.app/api/user/kakao');

    try {
      // 헤더 설정
      var headers = {
        'Authorization':
            'Bearer W9cvDkscHWrhUTsz3I2GBPJd1y4FH466AAAAAgo9cpcAAAGRRqNEdqbXH4eeWQ3B',
        'Content-Type': 'application/json',
      };

      // GET 요청
      var response = await http.post(
        url,
        headers: headers,
      );

      //var request = http.MultipartRequest('POST', url);
      //request.fields['Authorization'] = socialId!;

      //var streamedResponse = await request.send();
      //var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        print('Request successful');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        // Assuming 'access' is the key for the access token in headers
        String? accessToken = response.headers['access'];
        String? refreshToken = response.headers['refresh'];

        if (accessToken != null && refreshToken != null) {
          await saveTokens(accessToken, refreshToken);
        }
      }
      print('socialLogin : ${response.statusCode}');
      return response.statusCode;
    } catch (e) {
      print('$e');
      return 500;
    }
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
                          var result = await signInWithKakao();
                          int statusCode = result['statusCode'];
                          print("statusCode: $statusCode");
                          //String socialId = result['socialId'];
                          if (statusCode == 404) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (const ProfileScreen()),
                              ),
                            );
                          } else if (statusCode == 200) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainScaffold()),
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
                        onPressed: () {},
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

  Future<Map<String, dynamic>> signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카톡 있음 - 카카오톡으로 로그인 성공');
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}');
        int statusCode = await socialLogin(user.id.toString());
        if (statusCode == 200 || statusCode == 404) {
          setState(() {
            _loginPlatform = LoginPlatform.kakao;
          });
          await _saveLoginPlatForm(LoginPlatform.kakao);
        }
        return {
          'statusCode': statusCode,
          'socialId': user.id.toString(),
        };
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          print('로그인 취소');
          return {
            'statusCode': 500,
            'socialId': '',
          };
        }
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          User user = await UserApi.instance.me();
          print('사용자 정보 요청 성공'
              '\n회원번호: ${user.id}');
          int statusCode = await socialLogin(user.id.toString());
          if (statusCode == 200 || statusCode == 404) {
            setState(() {
              _loginPlatform = LoginPlatform.kakao;
            });
            await _saveLoginPlatForm(LoginPlatform.kakao);
          }
          return {
            'statusCode': statusCode,
            'socialId': user.id.toString(),
          };
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return {
            'statusCode': 500,
            'socialId': '',
          }; //
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카톡 없음 - 카카오계정으로 로그인 성공');
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}');
        int statusCode = await socialLogin(user.id.toString());
        print('구라치기\n');
        //int statusCode = 200;
        if (statusCode == 200 || statusCode == 404) {
          setState(() {
            _loginPlatform = LoginPlatform.kakao;
          });
          await _saveLoginPlatForm(LoginPlatform.kakao);
        }

        return {
          'statusCode': statusCode,
          'socialId': user.id.toString(),
        };
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return {
          'statusCode': 500,
          'socialId': '',
        }; //
      }
    }
  }

  // Future<Map<String, dynamic>> signInWithKakao(BuildContext context) async {
  //   try {
  //     bool isInstalled = await isKakaoTalkInstalled();
  //     //print(isInstalled);

  //     // 카카오톡 설치되어있으면 앱으로 로그인
  //     OAuthToken token = isInstalled
  //         ? await UserApi.instance.loginWithKakaoTalk()
  //         : await UserApi.instance.loginWithKakaoAccount();

  //     final url = Uri.parse('http://10.0.2.2:8080/api/user/kakao');

  //     final headers = {
  //       HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
  //       if (token.refreshToken != null) 'X-Refresh-Token': token.refreshToken!,
  //     };

  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //     );

  //     User user = await UserApi.instance.me();
  //     if (response.statusCode == 200 || response.statusCode == 404) {
  //       print('${user.kakaoAccount}');
  //       print('카카오 로그인 성공!');
  //       int statusCode = await socialLogin(user.id.toString());

  //       setState(() {
  //         _loginPlatform = LoginPlatform.kakao;
  //       });
  //       await _saveLoginPlatForm(LoginPlatform.kakao);
  //     }
  //     return {
  //       'statusCode': response.statusCode,
  //       'socialId': user.id.toString(),
  //     };
  //   } catch (error) {
  //     print("카카오톡 로그인 실패 $error");
  //     return {
  //       'statusCode': 500,
  //       'socialId': '',
  //     };
  //   }
  // }

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
