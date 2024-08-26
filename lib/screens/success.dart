import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/login_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  int index = 0;
  double scaleValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        scaleValue = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(60, 65, 92, 1).withOpacity(1.0),
      // appBar: AppBar(
      //   title: const Text('로그인'),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   backgroundColor: const Color.fromRGBO(60, 65, 92, 1),
      // ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 565 * height,
              left: 100 * width,
              right: 100 * width,
              child: OvalBlurBackground(
                color: emRed,
              ),
            ),
            // BackdropFilter 적용
            Positioned(
              top: 565 * height,
              left: 100 * width,
              right: 100 * width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 55 * width,
                        height: 13 * height,
                        decoration: BoxDecoration(
                          color: sub1.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 74 * width,
                        height: 25 * height,
                        decoration: BoxDecoration(
                          color: sub1.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 84 * width,
                        height: 23 * height,
                        decoration: BoxDecoration(
                          color: sub1.withOpacity(0.049),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 154 * width,
                        height: 53 * height,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          //borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
