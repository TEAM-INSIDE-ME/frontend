import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/colors.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    super.key,
    required this.title,
    required this.center,
    required this.lfText,
    required this.rtText,
    required this.lfTap,
    required this.rtTap,
  });

  Widget title;
  String center;
  String lfText;
  String rtText;
  VoidCallback lfTap;
  VoidCallback rtTap;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        width: 284 * width,
        height: 190 * height,
        decoration: BoxDecoration(
          color: bg1,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 16.0, left: 16.0, top: 6.0),
                child: title,
              ),
              Text(
                center,
                style: TextStyle(
                  color: sub3,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: lfTap,
                      child: Container(
                        width: 119 * width,
                        height: 40 * height,
                        decoration: BoxDecoration(
                          color: sub4,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            lfText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: rtTap,
                      child: Container(
                        width: 119 * width,
                        height: 40 * height,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            rtText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
