import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';

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
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 151,
                ),
                SizedBox(
                  height: 22,
                  child: Text(
                    "내 안의 이야기,나를 찾는 곳",
                    style: TextStyle(
                      color: sub1,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
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
                const SizedBox(
                  height: 34,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  height: 190,
                  width: 190,
                ),
                const SizedBox(
                  height: 95,
                ),
                const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    'SNS로 간편하게 로그인하세요',
                    style: TextStyle(
                      color: Color.fromARGB(255, 150, 154, 173),
                      fontSize: 12,
                      fontFamily: 'Pretendarad',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const LoginBtn(
                  path: 'kakao',
                  snsName: '카카오',
                  btnColor: Color.fromARGB(255, 253, 239, 171),
                  txtColor: Color.fromARGB(255, 74, 61, 3),
                ),
                const LoginBtn(
                  path: 'naver',
                  snsName: '네이버',
                  btnColor: Color.fromARGB(255, 211, 237, 200),
                  txtColor: Color.fromARGB(255, 63, 86, 52),
                ),
                const LoginBtn(
                  path: 'google',
                  snsName: '구글',
                  btnColor: Color.fromARGB(255, 209, 216, 251),
                  txtColor: Color.fromARGB(255, 60, 65, 92),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: 280,
        height: 53,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              Image.asset(
                'assets/icons/$path.png',
                height: 19,
                width: 17,
              ),
              const SizedBox(width: 63),
              Container(
                alignment: Alignment.center,
                width: 74,
                height: 17,
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
    );
  }
}
