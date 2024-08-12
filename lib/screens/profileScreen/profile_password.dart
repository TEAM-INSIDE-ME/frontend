import 'package:flutter/material.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileScreen/profile_password_setting.dart';
import 'package:frontend/screens/success.dart';
import 'package:frontend/widgets/profile_body.dart';

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

    return Body(
      message: '프라이버시는\n중요하니까요!',
      firstContent: Column(
        children: [
          Flexible(
            flex: 27,
            child: Container(
              color: emBlue,
              child: const Row(
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
          ),
          Flexible(
            flex: 243,
            fit: FlexFit.tight,
            child: Container(
              color: emGreen,
              child: Center(
                child: SizedBox(
                  height: 76 * height,
                  width: 224 * width,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const ProfilePasswordSetting()));
                    },
                    child: Container(
                      height: 76 * height,
                      width: 224 * width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: sub5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 170,
            child: Container(
              color: emRed,
            ),
          ),
          Flexible(
            flex: 37,
            child: Container(
              color: emYellow,
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
