import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';

class MarbleBackground extends StatelessWidget {
  Widget marble;
  double radius;

  MarbleBackground({
    super.key,
    required this.marble,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        height: radius * height,
        width: radius * width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
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
        child: marble,
      ),
    );
  }
}

class Marble extends StatelessWidget {
  String marbleName;

  Marble({
    super.key,
    required this.marbleName,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/marbles/$marbleName.png',
      scale: 1.0,
    );
  }
}

class OvalBlurBackground extends StatelessWidget {
  Color color;

  OvalBlurBackground({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return ClipOval(
      child: Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 125 * width,
              height: 160 * height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.65),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 285 * width,
              height: 300 * height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 340 * width,
              height: 390 * height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.049),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 350 * width,
              height: 400 * height,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                //borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadialBlurBackground extends StatelessWidget {
  Color color;

  RadialBlurBackground({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return ClipRRect(
      child: Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 220 * width,
              height: 220 * height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.35),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 250 * width,
              height: 250 * height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.07),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 330 * width,
              height: 330 * height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 380 * width,
              height: 380 * height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.045),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 450 * width,
              height: 450 * height,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                //borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
