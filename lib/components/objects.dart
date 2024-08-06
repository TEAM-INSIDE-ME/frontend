import 'package:flutter/material.dart';

class Orb extends StatelessWidget {
  Color color;
  Orb({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/ob_p.png',
      width: 50,
      height: 50,
      colorBlendMode: BlendMode.modulate,
      color: color,
    );
  }
}

class OrbBackground extends StatelessWidget {
  const OrbBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          color: Colors.white,
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
      ),
    );
  }
}
