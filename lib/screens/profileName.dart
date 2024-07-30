import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileGender.dart';
import 'package:frontend/widgets/profileScaffold.dart';

class ProfileNameScreen extends StatefulWidget {
  const ProfileNameScreen({super.key});

  @override
  State<ProfileNameScreen> createState() => _ProfileNameScreenState();
}

class _ProfileNameScreenState extends State<ProfileNameScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String _counterText = "0";
  TextEditingController textController = TextEditingController();
  String textContent = "";
  String errorTextVal = "";

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      order: 0,
      message: '안녕하세요 :)\n나의 이름을 적어주세요',
      firstContent: Column(
        children: [
          Flexible(
            flex: 125,
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(top: 36),
              child: Column(
                children: [
                  nameField(),
                  Container(
                    alignment: const Alignment(0.9, 0),
                    height: 16,
                    child: Text(
                      _isFocused ? "$_counterText/30" : ' ',
                      style: TextStyle(
                        color: sub2,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 317,
            fit: FlexFit.tight,
            child: Container(),
          ),
          Flexible(
            flex: 34,
            child: Center(
              child: Text(
                '정보는 나중에 다시 수정할 수 있어요 :)',
                style: TextStyle(
                  color: sub4,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      secondContent: NextButton(
        page: ProfileGenderScreen(
          name: textContent,
        ),
        isfilled: textContent == "",
      ),
    );
  }

  TextField nameField() {
    return TextField(
      controller: textController,
      focusNode: _focusNode,
      style: TextStyle(
        color: sub2,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
        hintText: '이름 혹은 별명을 입력해 주세요',
        hintStyle: TextStyle(
          color: sub4,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: errorTextVal == 'min'
            ? const Color.fromRGBO(255, 212, 212, 0.3)
            : _isFocused
                ? const Color.fromARGB(127, 197, 207, 255)
                : sub5,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorTextVal == 'min'
                ? const Color.fromRGBO(255, 212, 212, 1)
                : const Color.fromARGB(102, 209, 212, 224),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorTextVal == "min"
                ? const Color.fromRGBO(255, 212, 212, 1)
                : emBlue,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        counterText: "",
      ),
      maxLength: 30,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      cursorColor: sub3,
      cursorHeight: 19,
      cursorWidth: 1.5,
      autofocus: false,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: (value) {
        setState(() {
          _counterText = (value.length).toString();
          textContent = textController.text;
          if (value.isEmpty) {
            errorTextVal = 'min';
          } else {
            errorTextVal = '';
          }
        });
      },
      cursorErrorColor: emRed,
    );
  }
}
