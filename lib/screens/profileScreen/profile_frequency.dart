import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/scaffolds/profile_body.dart';

class ProfileFreq extends StatefulWidget {
  VoidCallback onTap;
  ProfileFreq({
    super.key,
    required this.onTap,
  });

  @override
  State<ProfileFreq> createState() => _ProfileFreqState();
}

class _ProfileFreqState extends State<ProfileFreq> {
  List<String> freq = ['주 1회', '주 3회', '주 5회', '매일 (주 7회)'];
  int? _value;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Body(
      message: '일기를 매일 작성하지 않아도\n괜찮아요!',
      firstContent: Column(
        children: [
          const Flexible(
            flex: 27,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '일주일 간의 목표 횟수를 설정해주세요',
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
            flex: 290,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 32),
              child: Wrap(
                direction: Axis.vertical,
                spacing: 10.0,
                children: List<Widget>.generate(
                  4,
                  (index) {
                    return SizedBox(
                      height: 49 * height,
                      width: 329 * width,
                      child: ChoiceChip(
                        padding: const EdgeInsets.all(0),
                        label: Container(
                          height: 49 * height,
                          width: 329 * width,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                            left: 19,
                          ),
                          child: Text(
                            freq[index],
                            style: TextStyle(
                              color: sub3,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        selected: _value == index,
                        labelStyle: TextStyle(
                          color: sub2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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
                ),
              ),
            ),
          ),
          Flexible(
            flex: 159,
            child: Container(),
          ),
        ],
      ),
      secondContent: NextButton(
        isfilled: _value != null,
        onTap: widget.onTap,
        index: 0,
      ),
    );
  }
}
