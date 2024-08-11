import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/colors.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.message,
    required this.firstContent,
    required this.secondContent,
  });

  final String message;
  final Widget firstContent;
  final Widget secondContent;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 839;
    final double width = MediaQuery.of(context).size.width / 393;

    return Padding(
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
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.message,
                    textWidthBasis: TextWidthBasis.parent,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: sub2,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 476,
            fit: FlexFit.tight,
            child: Container(
              child: widget.firstContent,
            ),
          ),
          Flexible(
            flex: 68,
            fit: FlexFit.tight,
            child: widget.secondContent,
          ),
          Flexible(
            flex: 62,
            fit: FlexFit.tight,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
