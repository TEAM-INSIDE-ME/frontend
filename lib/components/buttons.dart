import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/login_screen.dart';

class LoginBtn extends StatelessWidget {
  VoidCallback onPressed;
  final String snsName;
  final Color btnColor, txtColor;
  IconData iconData;

  LoginBtn({
    super.key,
    required this.onPressed,
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
        onPressed: onPressed,
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

class BackButtonCustom extends StatelessWidget {
  VoidCallback onTap;

  BackButtonCustom({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(157, 169, 204, 0.1),
                blurRadius: 30.0,
                spreadRadius: 2.2,
                offset: Offset(0, 2.2),
                blurStyle: BlurStyle.inner),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: sub3,
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  VoidCallback onTap;
  bool isfilled;
  int index;

  NextButton({
    super.key,
    required this.onTap,
    required this.isfilled,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return SizedBox(
      width: width * 329,
      height: height * 64,
      child: InkWell(
        onTap: isfilled ? onTap : null,
        highlightColor: primary,
        borderRadius: BorderRadius.circular(100),
        child: Ink(
          decoration: isfilled
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: primary,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: selectedBg,
                ),
          child: Center(
            child: Text(
              index == 0 ? '다음' : '인사이드미 시작하기',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
