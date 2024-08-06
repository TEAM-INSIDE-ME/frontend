import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/colors.dart';

class NextButton extends StatelessWidget {
  final Widget page;
  bool isfilled;

  NextButton({
    super.key,
    required this.page,
    required this.isfilled,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return SizedBox(
      width: width * 329,
      height: height * 64,
      child: InkWell(
        onTap: () {
          isfilled
              ? null
              : Navigator.push(
                  context,
                  SlideRightRoute(
                    page: page,
                  ),
                );
        },
        highlightColor: primary,
        borderRadius: BorderRadius.circular(100),
        child: Ink(
          decoration: isfilled
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(127, 197, 207, 255),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: primary),
          child: const Center(
            child: Text(
              '다음',
              style: TextStyle(
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

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
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

class NextButton1 extends StatelessWidget {
  final onTap;
  bool isfilled;

  NextButton1({
    super.key,
    required this.onTap,
    required this.isfilled,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return SizedBox(
      width: width * 329,
      height: height * 64,
      child: InkWell(
        onTap: onTap,
        highlightColor: primary,
        borderRadius: BorderRadius.circular(100),
        child: Ink(
          decoration: isfilled
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(127, 197, 207, 255),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: primary),
          child: const Center(
            child: Text(
              '다음',
              style: TextStyle(
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
