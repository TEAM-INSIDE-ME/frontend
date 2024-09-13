import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileScreen/profile_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/profile_screen.dart';

class ProfileReminder extends StatefulWidget {
  VoidCallback onTap;
  ProfileReminder({
    super.key,
    required this.onTap,
  });

  @override
  State<ProfileReminder> createState() => _ProfileReminderState();
}

class _ProfileReminderState extends State<ProfileReminder> {
  bool toggled = false;
  bool _isExpanded = false;
  DateTime date = DateTime.utc(2024, 1, 1, 22, 30);
  String isAmPm = 'PM';

  ExpansionTileController controller = ExpansionTileController();
  ExpansionTileController controller1 = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 852;

    return Body(
        message: '\n잊지 않게 알려드릴게요',
        firstContent: Column(
          children: [
            const Flexible(
              flex: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '푸시 알람을 설정하면\n일기 작성을 잊지 않도록 알려드려요',
                    textWidthBasis: TextWidthBasis.parent,
                    style: TextStyle(
                      color: Color.fromRGBO(104, 87, 64, 0.6),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 187,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: 123 * height,
                    margin: const EdgeInsets.symmetric(
                      vertical: 32,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: _isExpanded
                              ? ShapeDecoration(
                                  color: sub5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: sub5,
                                ),
                          child: ListTile(
                            title: Text(
                              '일기 알림',
                              style: TextStyle(
                                color: sub1,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ListTileStyle.list,
                            trailing: CupertinoSwitch(
                              value: toggled,
                              activeColor: primary,
                              onChanged: (bool value) {
                                setState(() {
                                  toggled = value;
                                  _isExpanded = !_isExpanded;
                                });
                              },
                            ),
                          ),
                        ),
                        AnimatedCrossFade(
                          firstChild: Container(), // 빈 컨테이너
                          secondChild: Column(
                            children: [
                              Container(
                                color: sub4,
                                height: 0.5 * height,
                                width: 293 * width,
                              ),
                              Container(
                                decoration: ShapeDecoration(
                                  color: sub5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    '시간대 설정',
                                    style: TextStyle(
                                      color: sub1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  style: ListTileStyle.list,
                                  trailing: GestureDetector(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            constraints: BoxConstraints(
                                                maxHeight: height * 270),
                                            padding: const EdgeInsets.all(6),
                                            color: Colors.grey[400],
                                            child: SafeArea(
                                              child: CupertinoDatePicker(
                                                onDateTimeChanged: (value) {
                                                  setState(() {
                                                    date = value;
                                                    date.hour < 12
                                                        ? isAmPm = 'AM'
                                                        : isAmPm = 'PM';
                                                  });
                                                },
                                                initialDateTime: DateTime.utc(
                                                    2024, 1, 1, 22, 30),
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      '${date.hour - 12} : ${date.minute} $isAmPm',
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          crossFadeState: _isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 350),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 202,
              child: Container(),
            ),
            Flexible(
              flex: 37,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          alignment: Alignment.center,
                          child: Container(
                            width: 284 * width,
                            height: 184 * height,
                            decoration: BoxDecoration(
                              color: bg1,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        right: 16.0, left: 16.0, top: 27.0),
                                    child: Text(
                                      '알림을 설정하지 않으실 건가요?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    '알림은 나중에 다시 설정할 수 있어요',
                                    style: TextStyle(
                                      color: sub3,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 18.0, left: 18.0, top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 119 * width,
                                            height: 40 * height,
                                            decoration: BoxDecoration(
                                              color: sub4,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '취소',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push<void>(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const ProfileScreen(
                                                  initialIndex: 5,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 119 * width,
                                            height: 40 * height,
                                            decoration: BoxDecoration(
                                              color: primary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '확인',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
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
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    '나중에 설정할래요',
                    style: TextStyle(
                      color: sub3,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: sub3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        secondContent: NextButton(
          isfilled: true,
          onTap: widget.onTap,
          index: 0,
        ));
  }
}
