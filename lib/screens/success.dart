import 'package:flutter/material.dart';
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
        body: index == 0
            ? Container(
                height: 353,
                width: 353,
                color: emRed,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: NextButton(
                    isfilled: false,
                    onTap: () {},
                    index: 0,
                  ),
                ),
              )
            : index == 1
                ? Container(
                    color: emGreen,
                  )
                : null);
  }
}
