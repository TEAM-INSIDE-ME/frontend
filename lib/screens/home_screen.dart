import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/custom_icons.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/models/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Scaffold(
      //appBar: AppBar(),
      //backgroundColor: const Color.fromRGBO(60, 65, 92, 1),
      body: Stack(
        children: [
          const HomeBackground(),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    height: 340 * height,
                  ),
                  Positioned(
                    top: 118 * height,
                    left: 14 * width,
                    right: 14 * width,
                    child: Container(
                      height: 57 * height,
                      width: 363 * width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: sub5),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: const Color.fromARGB(255, 157, 169, 204)
                                .withOpacity(0.1),
                            blurRadius: 4.0,
                            spreadRadius: 0.0,
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
                            marble: Icon(
                              Icons.add,
                              color: sub3,
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
                          MarbleBackground(
                            radius: 45,
                            marble: Container(),
                          ),
                          MarbleBackground(
                            radius: 45,
                            marble: Container(),
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
                    ),
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeBackground extends StatelessWidget {
  const HomeBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
