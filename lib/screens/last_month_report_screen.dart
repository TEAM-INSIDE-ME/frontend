import 'package:flutter/material.dart';

class LastMonthReportScreen extends StatelessWidget {
  const LastMonthReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지난 달 보고서'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
