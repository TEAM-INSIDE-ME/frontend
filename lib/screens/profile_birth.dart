import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:frontend/widgets/profile_body.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/components/buttons.dart';
import 'package:provider/provider.dart';

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
  var year = 'YYYY', month = 'MM', day = 'DD';

  var isTap = List<bool>.filled(3, false); //1번 탭했는지
  var testTap = List<bool>.filled(3, false); //2번 움직이는지
  //var testTap1 = List<bool>.filled(3, false); //2번 열었는지
  var testTapup = List<bool>.filled(3, false); //2번 눌린 영역
  var tap = false; //한 번 열었는지
  var isPopup = false;
  DateTime date = DateTime.now();
  var cnt = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;
    final dayProvider = Provider.of<InfoProvider>(context);

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
                  height: 53 * height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _isCupertinoDatePickerPopup(context, height, 0);
                        },
                        child: Container(
                          width: 110 * width,
                          height: 53 * height,
                          decoration: ShapeDecoration(
                            color: isTap[0] ? selectedBg : nonSelectedBg,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                topLeft: Radius.circular(100),
                              ),
                              side: BorderSide(
                                color: isTap[0]
                                    ? selectedBorder
                                    : nonSelectedBorder,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              year,
                              style: TextStyle(
                                fontSize: 16,
                                color: year == 'YYYY' ? sub4 : sub1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _isCupertinoDatePickerPopup(context, height, 1);
                        },
                        child: Container(
                          width: 109 * width,
                          height: 53 * height,
                          decoration: ShapeDecoration(
                            color: isTap[1] ? selectedBg : nonSelectedBg,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: isTap[1]
                                    ? selectedBorder
                                    : nonSelectedBorder,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              month.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 16,
                                color: month == 'MM' ? sub4 : sub1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _isCupertinoDatePickerPopup(context, height, 2);
                        },
                        child: Container(
                          width: 110 * width,
                          height: 53 * height,
                          decoration: ShapeDecoration(
                            color: isTap[2] ? selectedBg : nonSelectedBg,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(100),
                                topRight: Radius.circular(100),
                              ),
                              side: BorderSide(
                                color: isTap[2]
                                    ? selectedBorder
                                    : nonSelectedBorder,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              day.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 16,
                                color: day == 'DD' ? sub4 : sub1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 200,
            child: Container(
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
                      testTap = List.filled(3, false);
                      testTap[0] = true;
                    });
                  } else if (dx > 110 && dx <= 220)
                    // ignore: curly_braces_in_flow_control_structures
                    setState(() {
                      testTap = List.filled(3, false);
                      testTap[1] = true;
                    });
                  else
                    // ignore: curly_braces_in_flow_control_structures
                    setState(() {
                      testTap = List.filled(3, false);
                      testTap[2] = true;
                    });
                },
                onTap: () async {
                  setState(() {
                    isPopup = true;
                    tap = true;
                  });
                  await showCupertinoModalPopup<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        constraints: BoxConstraints(maxHeight: height * 270),
                        padding: const EdgeInsets.all(6),
                        color: Colors.grey[400],
                        child: SafeArea(
                          top: false,
                          child: CupertinoDatePicker(
                            maximumYear: 2024,
                            mode: CupertinoDatePickerMode.date,
                            dateOrder: DatePickerDateOrder.ymd,
                            initialDateTime: date,
                            maximumDate: DateTime.now(),
                            onDateTimeChanged: (DateTime selectedTime) {
                              setState(() {
                                testTapup[0] = DateTime.now() != selectedTime;
                                testTapup[1] =
                                    DateTime.now().month != selectedTime.month;
                                testTapup[2] =
                                    DateTime.now().day != selectedTime.day;

                                testTap[0] = date.year != selectedTime.year;

                                testTap[1] = date.month != selectedTime.month;

                                testTap[2] = date.day != selectedTime.day;

                                print(date);
                                date = selectedTime;
                                dayProvider.getBirth(date);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                  setState(() {
                    isPopup = false;
                    cnt += 1;
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
                          color: isPopup && testTap[0]
                              ? selectedBg
                              : nonSelectedBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(100),
                              topLeft: Radius.circular(100),
                            ),
                            side: BorderSide(
                              color: isPopup && testTap[0]
                                  ? selectedBorder
                                  : nonSelectedBorder,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tap
                                ? testTap[0]
                                    ? '${date.year}'
                                    : testTapup[0]
                                        ? '${date.year}'
                                        : 'YYYY'
                                : 'YYYY',
                            style: TextStyle(
                              fontSize: 16,
                              color: tap
                                  ? testTap[0]
                                      ? sub1
                                      : testTapup[0]
                                          ? sub1
                                          : sub4
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
                          color: isPopup && testTap[1]
                              ? selectedBg
                              : nonSelectedBg,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isPopup && testTap[1]
                                  ? selectedBorder
                                  : nonSelectedBorder,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tap
                                ? testTap[1]
                                    ? date.month.toString().padLeft(2, '0')
                                    : testTapup[1]
                                        ? date.month.toString().padLeft(2, '0')
                                        : 'MM'
                                : 'MM',
                            style: TextStyle(
                              fontSize: 16,
                              color: tap
                                  ? testTap[1]
                                      ? sub1
                                      : testTapup[1]
                                          ? sub1
                                          : sub4
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
                          color: isPopup && testTap[2]
                              ? selectedBg
                              : nonSelectedBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(100),
                              topRight: Radius.circular(100),
                            ),
                            side: BorderSide(
                              color: isPopup && testTap[2]
                                  ? selectedBorder
                                  : nonSelectedBorder,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tap
                                ? testTap[2]
                                    ? date.day.toString().padLeft(2, '0')
                                    : testTapup[2]
                                        ? date.day.toString().padLeft(2, '0')
                                        : 'DD'
                                : 'DD',
                            style: TextStyle(
                              fontSize: 16,
                              color: tap
                                  ? testTap[2]
                                      ? sub1
                                      : testTapup[2]
                                          ? sub1
                                          : sub4
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
          ),
        ],
      ),
      secondContent: NextButton(
        onTap: widget.onTap,
        isfilled: _value != null,
      ),
    );
  }

  void _isCupertinoDatePickerPopup(
      BuildContext context, double height, int order) async {
    setState(() {
      isTap[order] = true;
    });

    final itemsYears = List.generate(60, (i) => -i + 2024);
    final itemsMonths = List.generate(12, (i) => i + 1);
    final itemsDays = List.generate(31, (i) => i + 1);
    var result = [
      itemsYears[0],
      itemsMonths[0],
      itemsDays[0],
    ];

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(maxHeight: height * 270),
          padding: const EdgeInsets.all(6),
          color: Colors.grey[400],
          child: SafeArea(
            top: false,
            child: CupertinoPicker(
              itemExtent: 40.0,
              onSelectedItemChanged: (value) {
                setState(() {
                  if (order == 0) {
                    result[0] = itemsYears[value];
                    year = result[0].toString();
                  } else if (order == 1) {
                    result[1] = itemsMonths[value];
                    month = result[1].toString();
                  } else if (order == 2) {
                    result[2] = itemsDays[value];
                    day = result[2].toString();
                  }
                });
              },
              children: order == 0
                  ? itemsYears.map((e) => Center(child: Text('$e'))).toList()
                  : order == 1
                      ? itemsMonths
                          .map((e) =>
                              Center(child: Text(e.toString().padLeft(2, '0'))))
                          .toList()
                      : itemsDays
                          .map((e) =>
                              Center(child: Text(e.toString().padLeft(2, '0'))))
                          .toList(),
            ),
          ),
        );
      },
    );

    setState(() {
      isTap[order] = false;
    });
  }
}
