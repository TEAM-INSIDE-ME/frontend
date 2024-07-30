import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/colors.dart';

class ProfileScaffold extends StatelessWidget {
  final Widget firstContent;
  final Widget secondContent;
  final String message;
  final int order;

  const ProfileScaffold({
    super.key,
    required this.firstContent,
    required this.secondContent,
    required this.message,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 839;
    final double width = MediaQuery.of(context).size.width / 393;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 * height),
        child: AppBar(
          backgroundColor: bg,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(72 * height),
            child: Container(
              height: 48,
              width: 306,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 246, 253, 0.5),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 0.5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: emRed,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 0.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: emRed,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 0.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: emRed,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.white, width: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0 * width),
        child: Column(
          children: [
            Flexible(
              flex: 34,
              fit: FlexFit.tight,
              child: Container(),
            ),
            Flexible(
              flex: 68,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: sub1,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 476,
              fit: FlexFit.tight,
              child: Container(
                child: firstContent,
              ),
            ),
            Flexible(
              flex: 68,
              fit: FlexFit.loose,
              child: secondContent,
            ),
            Flexible(
              flex: 62,
              fit: FlexFit.tight,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
