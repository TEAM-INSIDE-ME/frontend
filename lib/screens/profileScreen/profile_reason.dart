import 'package:flutter/material.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/widgets/profile_body.dart';

class ProfileReason extends StatefulWidget {
  VoidCallback onTap;

  ProfileReason({
    super.key,
    required this.onTap,
  });

  @override
  State<ProfileReason> createState() => _ProfileReasonState();
}

class _ProfileReasonState extends State<ProfileReason> {
  final List<String> _filters = [];
  List<String> reasons = [
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
                  children: List<Widget>.generate(reasons.length, (index) {
                    return SizedBox(
                      width: 329 * width,
                      height: 49 * height,
                      child: FilterChip(
                        padding: const EdgeInsets.only(left: 13),
                        label: Container(
                          width: 329 * width,
                          height: 49 * height,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            reasons[index],
                            style: TextStyle(
                              color: _filters.contains(reasons[index])
                                  ? sub1
                                  : sub3,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        selectedColor: selectedBg,
                        backgroundColor: nonSelectedBg,
                        showCheckmark: false,
                        selected: _filters.contains(reasons[index]),
                        side: BorderSide(
                          color: _filters.contains(reasons[index])
                              ? selectedBorder
                              : nonSelectedBorder,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onSelected: (bool value) {
                          setState(() {
                            if (value) {
                              _filters.add(reasons[index]);
                            } else {
                              _filters.removeWhere((String name) {
                                return name == reasons[index];
                              });
                            }
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
          isfilled: _filters.isNotEmpty,
          onTap: widget.onTap,
          index: 0,
        ));
  }
}
