import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileScreen/profile_password.dart';
import 'package:frontend/screens/profileScreen/profile_password_input.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool toggled_mode = false;
  bool toggled_alert = false;
  bool toggled_password = false;
  DateTime date = DateTime.utc(2024, 1, 1, 22, 30);
  String isAmPm = 'PM';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 852;
    var timeProvider = Provider.of<InfoProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 16, bottom: 16),
                child: Text(
                  '설정',
                  style: TextStyle(
                    color: sub1,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CustomeContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '프로필 설정',
                      style: TextStyle(
                        color: sub1,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: sub3,
                      ),
                    ),
                  ],
                ),
              ),
              CustomeContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '시스템 설정',
                      style: TextStyle(
                        color: sub1,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '다크 모드',
                          style: TextStyle(
                            color: sub1.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CupertinoSwitch(
                          value: toggled_mode,
                          activeColor: primary,
                          onChanged: (bool value) {
                            setState(() {
                              toggled_mode = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                      color: sub4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '폰트',
                          style: TextStyle(
                            color: sub1.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Pretendard',
                          style: TextStyle(
                            color: primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomeContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '일기 알림',
                          style: TextStyle(
                            color: sub1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CupertinoSwitch(
                          value: toggled_alert,
                          activeColor: primary,
                          onChanged: (bool value) {
                            setState(() {
                              toggled_alert = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                      color: sub4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '시간대 설정',
                          style: TextStyle(
                            color: toggled_alert
                                ? sub1.withOpacity(0.8)
                                : sub1.withOpacity(0.2),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            toggled_alert
                                ? showCupertinoModalPopup(
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
                                            mode: CupertinoDatePickerMode.time,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : null;
                          },
                          child: Text(
                            '${date.hour - 12} : ${date.minute} $isAmPm',
                            style: TextStyle(
                              color: toggled_alert
                                  ? primary
                                  : primary.withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomeContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '비밀번호 설정',
                          style: TextStyle(
                            color: sub1,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CupertinoSwitch(
                          value: toggled_password,
                          activeColor: primary,
                          onChanged: (bool value) {
                            setState(() {
                              toggled_password = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                      color: sub4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '비밀번호 재설정',
                          style: TextStyle(
                            color: toggled_password
                                ? sub1.withOpacity(0.8)
                                : sub1.withOpacity(0.2),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color:
                                toggled_password ? sub3 : sub3.withOpacity(0.3),
                          ),
                          onTap: () => toggled_password
                              ? Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const ProfilePasswordInput(),
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomeContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '로그아웃',
                      style: TextStyle(
                        color: sub1,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: sub3,
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
  }
}

class CustomeContainer extends StatefulWidget {
  CustomeContainer({
    super.key,
    required this.child,
  });

  Widget child;

  @override
  State<CustomeContainer> createState() => _CustomeContainerState();
}

class _CustomeContainerState extends State<CustomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bg1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: StatefulBuilder(builder: (context, snapshot) {
        return widget.child;
      }),
    );
  }
}
