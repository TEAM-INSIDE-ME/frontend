import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';

class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 251, 251, 254);
    DateTime today = DateTime.now();

    return Scaffold(
      backgroundColor: backgroundColor,
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
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
        child: ClipRRect(
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: sub5,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${today.year}년 ${today.month}월 ${today.day}일',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      hintText: '제목',
                      hintStyle: TextStyle(
                        color: sub4,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const TextField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
