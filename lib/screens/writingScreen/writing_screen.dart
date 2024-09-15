import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';

class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 251, 251, 254);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(
          color: sub3,
        ),
        actions: [
          Wrap(
            spacing: 12,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.text_fields,
                  color: sub3,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.photo_outlined,
                  color: sub3,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.folder_copy_outlined,
                  color: sub3,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: sub3,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
      ),
    );
  }
}
