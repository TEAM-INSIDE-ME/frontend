import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/components/custom_icons.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/settingScreen/setting_screen.dart';
import 'package:frontend/screens/writingScreen/writing_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AnimationController 초기화 (1초마다 애니메이션 반복)
    _controller = AnimationController(
      duration: const Duration(seconds: 2, microseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // 애니메이션이 왔다 갔다 반복
  }

  @override
  void dispose() {
    _controller.dispose(); // 종료시 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Scaffold(
      //backgroundColor: const Color.fromRGBO(60, 65, 92, 1),
      body: Stack(
        children: [
          const HomeBackground(),
          Positioned(
            top: 90 * height,
            right: 20 * width,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const WritingScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.share,
                    color: sub3,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const SettingScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: sub3,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    height: 340 * height,
                  ),
                  Container(
                    height: 340 * height,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      border: Border.all(
                        color: const Color.fromARGB(255, 240, 242, 252),
                        width: 0.5,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 118 * height,
                    left: 14 * width,
                    right: 14 * width,
                    child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          // 그림자 효과 변화 계산
                          double shadowStrength =
                              sin(_controller.value * 2 * pi) * 4 +
                                  8; // spread와 blur의 변화값
                          return Container(
                            height: 57 * height,
                            width: 363 * width,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: sub5),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 157, 169, 204)
                                          .withOpacity(0.1),
                                  //blurRadius: 4.0,
                                  //spreadRadius: 0.0,
                                  spreadRadius:
                                      shadowStrength, // spread를 애니메이션에 맞춰 변화시킴
                                  blurRadius: shadowStrength *
                                      2, // blur를 애니메이션에 맞춰 변화시킴
                                  offset: const Offset(0.0, 2.0),
                                  blurStyle: BlurStyle.inner,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MarbleBackground(
                                  radius: 45,
                                  marble: IconButton(
                                    onPressed: () {
                                      print('hihih');
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const WritingScreen(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: sub3,
                                    ),
                                  ),
                                ),
                                MarbleBackground(
                                  radius: 45,
                                  marble: Marble(
                                    marbleName: 'blue_marble_1',
                                    radius: 45,
                                  ),
                                ),
                                MarbleBackground(
                                  radius: 45,
                                  marble: Marble(
                                    marbleName: 'green_marble_1',
                                    radius: 45,
                                  ),
                                ),
                                MarbleBackground(
                                  radius: 45,
                                  marble: Marble(
                                    marbleName: 'purple_marble_1',
                                    radius: 45,
                                  ),
                                ),
                                MarbleBackground(
                                  radius: 45,
                                  marble: Marble(
                                    marbleName: 'yellow_marble_1',
                                    radius: 45,
                                  ),
                                ),
                                MarbleBackground(
                                  radius: 45,
                                  marble: Container(),
                                ),
                                MarbleBackground(
                                  radius: 45,
                                  marble: Container(),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 325 * height,
            right: 0 * width,
            left: 200 * width,
            child: SvgPicture.asset('assets/images/bubble.svg'),
          ),
          Positioned(
            top: 365 * height,
            right: 0 * width,
            left: 0 * width,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/character_0.png',
                  height: 190 * height,
                  width: 190 * width,
                ),
                AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // 그림자 효과 변화 계산
                      double shadowStrength =
                          sin(_controller.value * 2 * pi) * 2 + 6;
                      // 물결처럼 일렁이는 효과 계산 (sin 함수를 이용)

                      return Container(
                        width: 134 * width,
                        height: 23 * height,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color.fromARGB(255, 178, 190, 225)
                                  .withOpacity(0.6),

                              blurRadius:
                                  shadowStrength * 8, // blur를 애니메이션에 맞춰 변화시킴
                              blurStyle: BlurStyle.normal,
                              spreadRadius: 15, // 그림자가 너무 넓게 퍼지지 않도록 설정

                              offset: const Offset(0, 0), // 그림자 위치도 살짝 변하게 설정
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 홈 화면 배경입니다람쥐.
class HomeBackground extends StatelessWidget {
  const HomeBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                bg1.withOpacity(0.7),
                primary.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [11 / 757, 629.5 / 757],
            ),
            //color: Color.fromRGBO(60, 65, 92, 1),
          ),
        ),
        Positioned.fill(
          top: 0 * height,
          left: -280 * width,
          child: OvalBlurBackground(color: emGreen),
        ),
        Positioned.fill(
          top: 0 * height,
          right: -280 * width,
          child: OvalBlurBackground(color: emYellow),
        ),
        Positioned.fill(
          top: -250 * height,
          child: OvalBlurBackground(color: emRed),
        ),
        Positioned.fill(
          top: 100 * height,
          child: RadialBlurBackground(color: emBlue),
        ),
      ],
    );
  }
}
