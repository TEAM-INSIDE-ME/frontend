import 'package:flutter/material.dart';
import 'package:frontend/components/buttons.dart';
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
  @override
  Widget build(BuildContext context) {
    return Body(
        message: 'Inside Me를\n이용하시는 이유가 궁금해요',
        firstContent: Container(),
        secondContent: NextButton(
          isfilled: true,
          onTap: () {
            widget.onTap;
          },
        ));
  }
}
