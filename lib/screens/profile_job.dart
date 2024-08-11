import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/widgets/profile_body.dart';

class ProfileJob extends StatefulWidget {
  VoidCallback onTap;

  ProfileJob({
    super.key,
    required this.onTap,
  });

  @override
  State<ProfileJob> createState() => _ProfileJobState();
}

class _ProfileJobState extends State<ProfileJob> {
  final List<String> _filters = [];

  List<String> jobs = [
    '사무직',
    '학생',
    '프리랜서',
    '공공기관/정부',
    '자영업/창업',
    '예술/창작',
    '연구/학문',
    '교육/교직',
    '기술/엔지니어링',
    '의료/보건',
    '서비스업',
    'IT/개발',
    '경영/관리',
    '금융/회계',
    '마케팅/홍보',
    '법률/법조',
    '건축/디자인',
    '과학/연구',
    '무직',
    '선택 안 함',
  ];

  @override
  Widget build(BuildContext context) {
    return Body(
      message: '\n어떤 일을 하시나요?',
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
                    '직업을 선택해 주세요',
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
            flex: 428,
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              child: Wrap(
                spacing: 10,
                children: List<Widget>.generate(jobs.length, (index) {
                  return FilterChip(
                    label: Text(
                      jobs[index],
                      style: TextStyle(
                        color: _filters.contains(jobs[index]) ? sub1 : sub3,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    selectedColor: selectedBg,
                    backgroundColor: nonSelectedBg,
                    showCheckmark: false,
                    selected: _filters.contains(jobs[index]),
                    side: BorderSide(
                      color: _filters.contains(jobs[index])
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
                          _filters.add(jobs[index]);
                        } else {
                          _filters.removeWhere((String name) {
                            return name == jobs[index];
                          });
                        }
                      });
                    },
                  );
                }),
              ),
            ),
          ),
          Flexible(
            flex: 21,
            child: Container(),
          )
        ],
      ),
      secondContent: NextButton(
        isfilled: _filters.isNotEmpty,
        onTap: widget.onTap,
        index: 0,
      ),
    );
  }
}
