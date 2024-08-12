import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/profileScreen/profile_password.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:provider/provider.dart';

class ProfilePasswordInput extends StatefulWidget {
  const ProfilePasswordInput({
    super.key,
  });

  @override
  State<ProfilePasswordInput> createState() => _ProfilePasswordInputState();
}

class _ProfilePasswordInputState extends State<ProfilePasswordInput> {
  String enteredPin = '';

  Widget numButton(int number, BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return SizedBox(
      width: 81 * width,
      height: 52 * height,
      child: TextButton(
          onPressed: () {
            setState(
              () {
                if (enteredPin.length < 4) {
                  enteredPin += number.toString();
                  if (enteredPin.length == 4) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePasswordInputAgain(
                          correctPin: enteredPin,
                        ),
                      ),
                    );
                  }
                }
              },
            );
          },
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 26,
              color: sub1,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 * height),
        child: AppBar(
          backgroundColor: bg,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(72 * height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: sub3,
                    )),
                Container(
                  width: 313 * width,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 70,
            child: Container(),
          ),
          Flexible(
            flex: 136,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '비밀번호 설정',
                    style: TextStyle(
                      color: sub1,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 19 * height,
                      top: 16 * height,
                    ),
                    child: const Text(
                      '사용할 비밀번호를 입력해 주세요',
                      style: TextStyle(
                        color: Color.fromRGBO(104, 87, 64, 0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 16 * width,
                        height: 16 * height,
                        margin: EdgeInsets.symmetric(horizontal: 16 * height),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: enteredPin.length <= index ? sub4 : primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 157,
            fit: FlexFit.tight,
            child: Container(),
          ),
          Flexible(
            flex: 315,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10 * height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < 3; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35 * width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (index) => numButton(1 + 3 * i + index, context),
                        ).toList(),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35 * width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 81 * width,
                          height: 52 * height,
                        ),
                        numButton(0, context),
                        SizedBox(
                          width: 81 * width,
                          height: 52 * height,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (enteredPin.isNotEmpty) {
                                    enteredPin = enteredPin.substring(
                                        0, enteredPin.length - 1);
                                  }
                                });
                              },
                              child: Icon(
                                Icons.arrow_back_sharp,
                                color: sub1,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 30,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class ProfilePasswordInputAgain extends StatefulWidget {
  String correctPin = '';

  ProfilePasswordInputAgain({
    super.key,
    required this.correctPin,
  });

  @override
  State<ProfilePasswordInputAgain> createState() =>
      _ProfilePasswordInputAgainState();
}

class _ProfilePasswordInputAgainState extends State<ProfilePasswordInputAgain> {
  String enteredPin = '';

  Widget numButton(int number, BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;
    final pwProvider = Provider.of<InfoProvider>(context);

    return SizedBox(
      width: 81 * width,
      height: 52 * height,
      child: TextButton(
          onPressed: () {
            setState(
              () {
                if (enteredPin.length < 4) {
                  enteredPin += number.toString();
                  if (enteredPin.length == 4) {
                    if (enteredPin == widget.correctPin) {
                      // 일치하면
                      pwProvider.getPassword(enteredPin);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      enteredPin = '';
                    }
                  }
                }
              },
            );
          },
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 26,
              color: sub1,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 * height),
        child: AppBar(
          backgroundColor: bg,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(72 * height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: sub3,
                    )),
                Container(
                  width: 313 * width,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 70,
            child: Container(),
          ),
          Flexible(
            flex: 136,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '비밀번호 설정',
                    style: TextStyle(
                      color: sub1,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 19 * height,
                      top: 16 * height,
                    ),
                    child: const Text(
                      '비밀번호를 한번 더 입력해 주세요',
                      style: TextStyle(
                        color: Color.fromRGBO(104, 87, 64, 0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 16 * width,
                        height: 16 * height,
                        margin: EdgeInsets.symmetric(horizontal: 16 * height),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: enteredPin.length <= index ? sub4 : primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 157,
            fit: FlexFit.tight,
            child: Container(),
          ),
          Flexible(
            flex: 315,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10 * height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < 3; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35 * width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (index) => numButton(1 + 3 * i + index, context),
                        ).toList(),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35 * width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 81 * width,
                          height: 52 * height,
                        ),
                        numButton(0, context),
                        SizedBox(
                          width: 81 * width,
                          height: 52 * height,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (enteredPin.isNotEmpty) {
                                    enteredPin = enteredPin.substring(
                                        0, enteredPin.length - 1);
                                  }
                                });
                              },
                              child: Icon(
                                Icons.arrow_back_sharp,
                                color: sub1,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 30,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
