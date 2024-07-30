import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/models/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: TextField(
            keyboardType: TextInputType.phone,
          ),
        ),
      ),
    );
  }
}
