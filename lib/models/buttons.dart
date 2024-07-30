import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileGender.dart';
import 'package:frontend/screens/success.dart';

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
