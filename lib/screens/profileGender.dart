import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/buttons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profileBirth.dart';
import 'package:frontend/screens/profileName.dart';
import 'package:frontend/screens/success.dart';
import 'package:frontend/widgets/profileScaffold.dart';

class ProfileGenderScreen extends StatefulWidget {
  String name;
  ProfileGenderScreen({
    super.key,
    required this.name,
  });

  @override
  State<ProfileGenderScreen> createState() => _ProfileGenderScreenState();
}

class _ProfileGenderScreenState extends State<ProfileGenderScreen> {
  int? _value = 2;
  List<String> genders = ['여성', '남성'];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 839;
    final double width = MediaQuery.of(context).size.width / 393;

    return ProfileScaffold(
      order: 1,
      message: '${widget.name} 님에 대해\n알고 싶어요!',
      firstContent: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3000,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 12.0,
                children: List<Widget>.generate(
                  2,
                  (index) {
                    return SizedBox(
                      width: width * 156,
                      height: height * 53,
                      child: ChoiceChip(
                        label: Container(
                          alignment: Alignment.centerLeft,
                          width: width * 156,
                          height: height * 53,
                          child: Text(
                            genders[index],
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: sub2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        selected: _value == index,
                        selectedColor: const Color.fromARGB(127, 197, 207, 255),
                        backgroundColor: sub5,
                        side: BorderSide(
                          color: _value == index
                              ? emBlue
                              : const Color.fromARGB(102, 209, 212, 224),
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
                ).toList(),
              ),
            ),
          ),
          Flexible(
            flex: 5814,
            child: Container(),
          ),
        ],
      ),
      secondContent: NextButton(
        page: const ProfileBirthScreen(),
        isfilled: true,
      ),
    );
  }
}
