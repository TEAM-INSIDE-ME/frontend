import 'package:flutter/material.dart';
import 'package:frontend/widgets/profileScaffold.dart';

class ProfileBirthScreen extends StatelessWidget {
  const ProfileBirthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      order: 2,
      message: '\n생일이 언제인가요?',
      firstContent: Container(),
      secondContent: Container(),
    );
  }
}
