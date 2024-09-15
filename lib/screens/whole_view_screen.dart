import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';

class WholeViewScreen extends StatelessWidget {
  const WholeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전체 기록 '),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: sub3,
        ),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
