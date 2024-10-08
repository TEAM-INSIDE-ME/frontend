import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/custom_dialog.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileScreen/profile_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 852;

    // remind 시간 Provider
    final timeProvider = Provider.of<InfoProvider>(context);

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
                                  toggled
                                      ? timeProvider.saveRemindTime("22:30")
                                      : timeProvider.saveRemindTime('');
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
                                                    // reminde time 저장
                                                    String time =
                                                        "${date.hour}:${date.minute}";
                                                    timeProvider
                                                        .saveRemindTime(time);
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
                        return CustomDialog(
                          title: const Text(
                            '알림을 설정하지 않으실 건가요?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          center: '알림은 나중에 다시 설정할 수 있어요',
                          lfText: '취소',
                          rtText: '확인',
                          lfTap: () {
                            Navigator.pop(context);
                          },
                          rtTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ProfileScreen(
                                  initialIndex: 5,
                                ),
                              ),
                            );
                          },
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
