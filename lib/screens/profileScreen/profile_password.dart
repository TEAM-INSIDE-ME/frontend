import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileScreen/profile_password_input.dart';
import 'package:frontend/screens/success.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:frontend/widgets/profile_body.dart';
import 'package:provider/provider.dart';

class ProfilePassword extends StatelessWidget {
  VoidCallback onTap;
  ProfilePassword({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;
    final pwProvider = Provider.of<InfoProvider>(context);

    return Body(
      message: '프라이버시는\n중요하니까요!',
      firstContent: Column(
        children: [
          const Flexible(
            flex: 27,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '앱 실행 시 비밀번호를 설정할 수 있어요',
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
            flex: 243,
            fit: FlexFit.tight,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 76 * height,
                    width: 224 * width,
                    margin: EdgeInsets.only(top: 84 * height),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfilePasswordInput(),
                          ),
                        );
                      },
                      child: Container(
                        height: 76 * height,
                        width: 224 * width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: sub5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List<Widget>.generate(
                              4,
                              (index) => Container(
                                width: 16 * width,
                                height: 16 * height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: pwProvider.password == ''
                                      ? sub4
                                      : primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: pwProvider.password == '' ? false : true,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfilePasswordInput(),
                        ),
                      );
                    },
                    child: Container(
                      height: 33 * height,
                      width: 110 * width,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 16 * height),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: sub5,
                      ),
                      child: Text(
                        '비밀번호 재설정',
                        style: TextStyle(
                          color: sub4,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 170,
            child: Container(),
          ),
          Flexible(
            flex: 37,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showAboutDialog(context: context);
                },
                child: Text(
                  '비밀번호 설정 안하고 시작할래요!',
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
        onTap: onTap,
        index: 1,
      ),
    );
  }
}
