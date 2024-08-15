import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MarbleBackground extends StatelessWidget {
  Widget marble;

  MarbleBackground({
    super.key,
    required this.marble,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        height: 38 * height,
        width: 38 * width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(100),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(157, 169, 204, 0.1),
                blurRadius: 30.0,
                spreadRadius: 2.2,
                offset: Offset(0, 2.2),
                blurStyle: BlurStyle.inner),
          ],
        ),
        child: marble,
      ),
    );
  }
}
