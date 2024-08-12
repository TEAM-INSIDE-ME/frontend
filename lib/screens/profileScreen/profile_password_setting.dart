import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/models/colors.dart';

class ProfilePasswordSetting extends StatefulWidget {
  const ProfilePasswordSetting({super.key});

  @override
  State<ProfilePasswordSetting> createState() => _ProfilePasswordSettingState();
}

class _ProfilePasswordSettingState extends State<ProfilePasswordSetting> {
  String enteredPin = '';
  bool isPinVisible = false;

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
          onPressed: () {
            setState(() {
              if (enteredPin.length < 4) {
                enteredPin += number.toString();
              }
            });
          },
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 24,
              color: sub1,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 * height),
        child: AppBar(
          //backgroundColor: bg,
          backgroundColor: const Color.fromRGBO(60, 65, 92, 1),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(72 * height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: sub3,
                    )),
                Container(
                  width: 313,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 70,
            child: Container(),
          ),
          Flexible(
            flex: 136,
            child: Container(
              color: emBlue,
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  //physics: const BouncingScrollPhysics(),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '비밀 번호 설정',
                            style: TextStyle(
                              color: sub2,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            '사용할 비밀번호를 입력해 주세요',
                            style: TextStyle(
                              color: Color.fromRGBO(104, 87, 64, 0.6),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              4,
                              (index) {
                                return Container(
                                  margin: const EdgeInsets.all(6),
                                  width: isPinVisible ? 50 : 16,
                                  height: isPinVisible ? 50 : 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: index < enteredPin.length
                                        ? isPinVisible
                                            ? Colors.green
                                            : primary
                                        : sub4,
                                  ),
                                  child: isPinVisible &&
                                          index < enteredPin.length
                                      ? Center(
                                          child: Text(
                                            enteredPin[index],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        )
                                      : null,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 159,
            fit: FlexFit.tight,
            child: Container(
              color: emRed,
              // child: IconButton(
              //   onPressed: () {
              //     setState(() {
              //       isPinVisible = !isPinVisible;
              //     });
              //   },
              //   icon: Icon(
              //     isPinVisible ? Icons.video_call_outlined : Icons.visibility,
              //   ),
              // ),
            ),
          ),
          Flexible(
            flex: 313,
            child: Container(
              color: emYellow,
              child: Column(
                children: [
                  for (var i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (index) => numButton(1 + 3 * i + index),
                        ).toList(),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextButton(onPressed: null, child: SizedBox()),
                        numButton(0),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                if (enteredPin.isNotEmpty) {
                                  enteredPin = enteredPin.substring(
                                      0, enteredPin.length - 1);
                                }
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: sub1,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 30,
            child: Container(
              color: emGreen,
            ),
          ),
        ],
      ),
    );
  }
}
