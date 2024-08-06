import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/widgets/profileScaffold.dart';

class ProfileBirthScreen extends StatelessWidget {
  const ProfileBirthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      order: 2,
      message: '\n생일이 언제인가요?',
      firstContent: Row(
        children: [
          Orb(
            color: emBlue,
          ),
          Orb(
            color: emYellow,
          ),
          Orb(
            color: emGreen,
          ),
          Image.asset(
            'assets/images/ob.png',
            width: 50,
            height: 50,
            colorBlendMode: BlendMode.modulate,
            color: emRed,
          ),
          Stack(
            children: [
              Image.asset(
                'assets/images/ob.png',
                width: 50,
                height: 50,
                colorBlendMode: BlendMode.modulate,
                color: emBlue,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(116, 141, 141, 58),
                  borderRadius: BorderRadius.circular(100),
                  //border: Border.all(color: Colors.white, width: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
      secondContent: Container(),
    );
  }
}
