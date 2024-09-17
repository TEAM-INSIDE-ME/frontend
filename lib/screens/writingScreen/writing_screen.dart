import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 251, 251, 254);
    DateTime today = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 공간 겹치게
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
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
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
          child: Container(
            height: 3500,
            decoration: BoxDecoration(
              color: sub5,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '${today.year}년 ${today.month}월 ${today.day}일',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextFormField(
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: InputDecoration(
                        hintText: '제목',
                        hintStyle: TextStyle(
                          color: sub4,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none, // 테두리 없앰
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.32,
                      ),
                      cursorColor: Colors.black,
                      cursorHeight: 22,
                      scrollPadding: const EdgeInsets.all(0),
                    ),
                    TextFormField(
                      maxLines: 130,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.32,
                      ),
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: InputDecoration(
                        hintText: '오늘 하루는 어땠나요?',
                        hintStyle: TextStyle(
                          color: sub4,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black,
                      cursorHeight: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
