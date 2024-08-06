import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/components/profile_body.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/components/buttons.dart';

class ProfileBirth extends StatefulWidget {
  VoidCallback onTap;
  String name;

  ProfileBirth({
    super.key,
    required this.onTap,
    required this.name,
  });

  @override
  State<ProfileBirth> createState() => _BirthState();
}

class _BirthState extends State<ProfileBirth> {
  int? _value = 2;
  List<String> genders = ['여성', '남성'];
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Body(
      message: '${widget.name} 님에 대해\n알고 싶어요!',
      firstContent: Column(
        children: [
          Flexible(
            flex: 26,
            child: Container(),
          ),
          Flexible(
            flex: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16 * height),
                  child: const Text(
                    '성별을 선택해 주세요',
                    style: TextStyle(
                      color: Color.fromRGBO(104, 87, 64, 0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 12.0,
                  children: List<Widget>.generate(
                    2,
                    (index) {
                      return SizedBox(
                        width: width * 156,
                        height: height * 53,
                        child: ChoiceChip(
                          label: Container(
                            alignment: Alignment.center,
                            width: width * 156,
                            height: height * 53,
                            child: Text(
                              genders[index],
                              style: TextStyle(
                                color: sub3,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: sub2,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          selected: _value == index,
                          selectedColor:
                              const Color.fromARGB(127, 197, 207, 255),
                          backgroundColor: sub5,
                          side: BorderSide(
                            color: _value == index
                                ? emBlue
                                : const Color.fromARGB(102, 209, 212, 224),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          showCheckmark: false,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                            });
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 19, 0, 16),
                  child: Text(
                    '생년월일을 입력해 주세요',
                    style: TextStyle(
                      color: Color.fromRGBO(104, 87, 64, 0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: 53 * height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    color: emRed,
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 200,
            child: Container(),
          ),
        ],
      ),
      secondContent: NextButton(
        onTap: widget.onTap,
        isfilled: _value != 0 && _value != 1,
      ),
    );
  }
}
