import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/components/buttons.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: sub2,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 190,
                height: 330,
                color: Colors.pink[200],
                child: SvgPicture.asset(
                  'assets/images/marbles/character.svg',
                ),
              ),
              Container(
                width: 190,
                height: 330,
                color: Colors.pink[200],
                child: Image.asset(
                  'assets/images/marbles/character.png',
                ),
              ),
            ],
          ),
          // Container(
          //   color: Colors.cyan[50],
          //   child: SvgPicture.asset(
          //     'assets/images/marbles/icon.svg',
          //     //colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn,)
          //   ),
          // ),
          // Container(
          //   width: 130,
          //   height: 130,
          //   color: Colors.cyan[50],
          //   child: SvgPicture.asset(
          //     'assets/images/marbles/logo.svg',
          //     //colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn,)
          //   ),
          // ),
        ],
      ),
    );
  }
}
