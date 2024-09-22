import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/utils/user_auth_manager.dart';
import 'package:http/http.dart' as http;

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final formKey = GlobalKey<FormState>();
  final formKey_title = GlobalKey<FormState>();
  final formKey_content = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool isExpanded = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // var url =
  //     Uri.parse('http://localhost:8080/api/diaries/createADiary/3613263264');
  // String token =
  //     '_M0DwW04SQXdrPigzcG2dTQRqgpw-kMMAAAAAQo8I-gAAAGSBca1jKbXH4eeWQ3B';
  // String refreshToken =
  //     '7UK9l0tgSS-2mlIiEYxZQzyaw0F1fMBtAAAAAgo8I-gAAAGSBca1iabXH4eeWQ3B';

  // Future<void> saveDiary() async {
  //   final headers = {
  //     HttpHeaders.authorizationHeader: 'Bearer $token',
  //     'X-Refresh-Token': refreshToken,
  //   };
  //   final response = await http.post(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode({
  //       "title": titleController.text,
  //       "content": contentController.text,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print('일기를 성공적으로 저장!');
  //   } else {
  //     print('오류 오류 ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 251, 251, 254);
    DateTime today = DateTime.now();
    double size = 1800;

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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    //saveDiary();
                    setState(() {
                      size = 400;
                      isExpanded = !isExpanded;
                      // 5초 후에 isLoading을 false로 변경하여 Container를 보여줌
                      Future.delayed(const Duration(seconds: 5), () {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    });
                  }
                },
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
      body: StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
            child: Column(
              children: [
                Container(
                  height: size,
                  decoration: isExpanded
                      ? ShapeDecoration(
                          color: sub5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: sub5,
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
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            style: ListTileStyle.list,
                            title: Column(
                              children: [
                                TextFormField(
                                  key: formKey_title,
                                  controller: titleController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '내용을 입력해주세요.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTapOutside: (event) => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
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
                                  key: formKey_content,
                                  controller: contentController,
                                  maxLines: 10,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '내용이 없습니다.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  scrollPhysics:
                                      const NeverScrollableScrollPhysics(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.32,
                                  ),
                                  onTapOutside: (event) => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
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
                                AnimatedCrossFade(
                                  firstChild: Container(), // 빈 컨테이너
                                  secondChild: isLoading
                                      ? Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              height: 0.5,
                                              width: 293,
                                            ),
                                            Container(
                                              decoration: ShapeDecoration(
                                                color: sub5,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  '오늘의 일기 분석 📖\n',
                                                  style: TextStyle(
                                                    color: sub1,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                style: ListTileStyle.list,
                                                subtitle: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                        '\n일기를 분석 중입니다.\n'),
                                                    CircularProgressIndicator(
                                                      color: primary,
                                                      strokeWidth: 3, // 원의 두께
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(primary),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              height: 0.5,
                                              width: 293,
                                            ),
                                            Container(
                                              decoration: ShapeDecoration(
                                                color: sub5,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  '오늘의 일기 분석 📖',
                                                  style: TextStyle(
                                                    color: sub1,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                style: ListTileStyle.list,
                                                subtitle: const Text(
                                                  '\n오늘 아침에는 중요한 프로젝트 회의로 긴장 상태였지만, 회의가 성공적으로 끝나면서 안도감과 뿌듯함을 느꼈다. 오후에는 친구와 카페에서 즐거운 시간을 보내며 많이 웃었고, 저녁에는 집에서 책을 읽으며 평온한 시간을 가졌다. 전반적으로, 오늘은 긴장과 안도, 그리고 즐거움과 평온이 공존하는 하루였어.',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  crossFadeState: isExpanded
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 350),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
