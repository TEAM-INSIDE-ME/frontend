import 'package:flutter/material.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileScreen/profile_body.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:provider/provider.dart';

class ProfilePurpose extends StatefulWidget {
  VoidCallback onTap;

  ProfilePurpose({
    super.key,
    required this.onTap,
  });

  @override
  State<ProfilePurpose> createState() => _ProfilePurposeState();
}

class _ProfilePurposeState extends State<ProfilePurpose> {
  int? _value;
  List<String> purpose = [
    '하루 기록',
    '감정 정리',
    '스트레스 해소',
    '기분 변화 추적',
    '목표 설정 및 달성',
    '습관 형성',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    final purposeProvider = Provider.of<InfoProvider>(context);

    return Body(
        message: 'Inside Me를\n이용하시는 이유가 궁금해요',
        firstContent: Column(
          children: [
            const Flexible(
              flex: 27,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '서비스를 이용하고자 하는 이유를 선택해 주세요',
                      style: TextStyle(
                        color: Color.fromRGBO(104, 87, 64, 0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 449,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 8,
                  children: List<Widget>.generate(purpose.length, (index) {
                    return SizedBox(
                      width: 329 * width,
                      height: 49 * height,
                      child: ChoiceChip(
                        padding: const EdgeInsets.only(left: 13),
                        label: Container(
                          width: 329 * width,
                          height: 49 * height,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            purpose[index],
                            style: TextStyle(
                              color: _value == index ? sub1 : sub3,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        selectedColor: selectedBg,
                        backgroundColor: nonSelectedBg,
                        showCheckmark: false,
                        selected: _value == index,
                        side: BorderSide(
                          color: _value == index
                              ? selectedBorder
                              : nonSelectedBorder,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? index : null;
                            purposeProvider.savePurpose(purpose[_value!]);
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
        secondContent: NextButton(
          isfilled: _value != null,
          onTap: widget.onTap,
          index: 0,
        ));
  }
}
