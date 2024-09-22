import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:frontend/screens/profileScreen/profile_body.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/components/buttons.dart';
import 'package:provider/provider.dart';

class ProfileBirth extends StatefulWidget {
  VoidCallback onTap;

  ProfileBirth({
    super.key,
    required this.onTap,
  });

  @override
  State<ProfileBirth> createState() => _BirthState();
}

class _BirthState extends State<ProfileBirth> {
  int? _value;
  List<String> genders = ['여성', '남성'];
  var year = 'YYYY', month = 'MM', day = 'DD';

  var isTap = List<bool>.filled(3, false); // 눌린 영역
  var isChanging = List<bool>.filled(3, false); // 움직이는 지
  var tap = false; //한 번 열었는지
  var isPopup = false; // 열려 있는지

  DateTime date = DateTime(2002, 01, 01);
  int _lastYear = DateTime.now().year;
  int _lastMonth = DateTime.now().month;
  int _lastDay = DateTime.now().day;

  var cnt = 0;

  void _onDateChanged(DateTime newDate) {
    if (newDate.year != _lastYear) {
      print('년도가 바꼈다!!!');
      setState(() {
        isChanging = List.filled(3, false);
        isChanging[0] = true;
      });
    }
    if (newDate.month != _lastMonth) {
      print('월이 바뀌었다람쥐~');
      setState(() {
        isChanging = List.filled(3, false);
        isChanging[1] = true;
      });
    }
    if (newDate.day != _lastDay) {
      print('이번에는 일이당~~');
      setState(() {
        isChanging = List.filled(3, false);
        isChanging[2] = true;
      });
    }

    _lastYear = newDate.year;
    _lastMonth = newDate.month;
    _lastDay = newDate.day;

    setState(() {
      date = newDate;
      isTap = List.filled(3, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    // Provider
    final textProvider = Provider.of<InfoProvider>(context);
    final genderProvider = Provider.of<InfoProvider>(context);
    final dayProvider = Provider.of<InfoProvider>(context);

    return Body(
      message: '${textProvider.name} 님에 대해\n알고 싶어요!',
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
                          padding: const EdgeInsets.all(0),
                          label: Container(
                            width: 156 * width,
                            height: 53 * height,
                            alignment: Alignment.center,
                            child: Text(
                              genders[index],
                              textScaler: const TextScaler.linear(1.2),
                              style: TextStyle(
                                color: _value == index ? sub1 : sub3,
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
                          selectedColor: selectedBg,
                          backgroundColor: nonSelectedBg,
                          side: BorderSide(
                            color: _value == index
                                ? selectedBorder
                                : nonSelectedBorder,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          showCheckmark: false,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                              genderProvider.saveGender(genders[_value!]);
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
                //birthPicker(height, width),
                Container(
                  width: 330 * width,
                  height: 53 * height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: GestureDetector(
                    onTapUp: (details) {
                      final dx = details.localPosition.dx;
                      if (dx <= 110) {
                        setState(() {
                          isTap = List.filled(3, false);
                          isTap[0] = true;
                        });
                      } else if (dx > 110 && dx <= 220)
                        // ignore: curly_braces_in_flow_control_structures
                        setState(() {
                          isTap = List.filled(3, false);
                          isTap[1] = true;
                        });
                      else
                        // ignore: curly_braces_in_flow_control_structures
                        setState(() {
                          isTap = List.filled(3, false);
                          isTap[2] = true;
                        });
                    },
                    onTap: () async {
                      setState(() {
                        isPopup = true;
                        tap = true;
                        dayProvider.saveBirth(date);
                      });
                      await showCupertinoModalPopup<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            constraints:
                                BoxConstraints(maxHeight: height * 270),
                            padding: const EdgeInsets.all(6),
                            color: Colors.grey[400],
                            child: SafeArea(
                              top: false,
                              child: CupertinoDatePicker(
                                maximumYear: 2024,
                                mode: CupertinoDatePickerMode.date,
                                dateOrder: DatePickerDateOrder.ymd,
                                //initialDateTime: DateTime(2002, 01, 01),
                                initialDateTime: date,
                                maximumDate: DateTime.now(),
                                onDateTimeChanged: (DateTime selectedTime) {
                                  setState(() {
                                    _onDateChanged(selectedTime);
                                    dayProvider.saveBirth(date);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ).then((_) {
                        setState(() {
                          isPopup = false;
                          isChanging = List.filled(3, false);
                        });
                      });
                    },
                    child: SizedBox(
                      width: 330 * width,
                      height: 53 * height,
                      child: Row(
                        children: [
                          Container(
                            width: 110 * width,
                            height: 53 * height,
                            decoration: ShapeDecoration(
                              color: isPopup
                                  ? isTap[0]
                                      ? selectedBg
                                      : isChanging[0]
                                          ? selectedBg
                                          : nonSelectedBg
                                  : nonSelectedBg,
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                  topLeft: Radius.circular(100),
                                ),
                                side: BorderSide(
                                  color: isPopup
                                      ? isTap[0]
                                          ? selectedBorder
                                          : isChanging[0]
                                              ? selectedBorder
                                              : nonSelectedBorder
                                      : nonSelectedBorder,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                isChanging[0]
                                    ? '${date.year}'
                                    : tap
                                        ? '${date.year}'
                                        : 'YYYY',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isChanging[0]
                                      ? sub1
                                      : tap
                                          ? sub1
                                          : sub4,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 109 * width,
                            height: 53 * height,
                            decoration: ShapeDecoration(
                              color: isPopup
                                  ? isTap[1]
                                      ? selectedBg
                                      : isChanging[1]
                                          ? selectedBg
                                          : nonSelectedBg
                                  : nonSelectedBg,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: isPopup
                                      ? isTap[1]
                                          ? selectedBorder
                                          : isChanging[1]
                                              ? selectedBorder
                                              : nonSelectedBorder
                                      : nonSelectedBorder,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                isChanging[1]
                                    ? date.month.toString().padLeft(2, '0')
                                    : tap
                                        ? date.month.toString().padLeft(2, '0')
                                        : 'MM',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isChanging[1]
                                      ? sub1
                                      : tap
                                          ? sub1
                                          : sub4,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 110 * width,
                            height: 53 * height,
                            decoration: ShapeDecoration(
                              color: isPopup
                                  ? isTap[2]
                                      ? selectedBg
                                      : isChanging[2]
                                          ? selectedBg
                                          : nonSelectedBg
                                  : nonSelectedBg,
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(100),
                                  topRight: Radius.circular(100),
                                ),
                                side: BorderSide(
                                  color: isPopup
                                      ? isTap[2]
                                          ? selectedBorder
                                          : isChanging[2]
                                              ? selectedBorder
                                              : nonSelectedBorder
                                      : nonSelectedBorder,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                isChanging[2]
                                    ? date.day.toString().padLeft(2, '0')
                                    : tap
                                        ? date.day.toString().padLeft(2, '0')
                                        : 'DD',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isChanging[2]
                                      ? sub1
                                      : tap
                                          ? sub1
                                          : sub4,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
        isfilled: _value != null && date.year != DateTime.now().year,
        index: 0,
      ),
    );
  }
}
