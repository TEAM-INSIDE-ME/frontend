import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/models/diary.dart';
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
  bool isLoading = false; // 서버 로딩 중
  bool isSaved = false; // 일기 저장했는지

  String output = ''; // 서버 응답에서 받은 output

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> postDiary({
    required String font,
    required String title,
    required String content,
  }) async {
    String? userId = await getUserId();
    final url = Uri.parse('$forwardUrl/api/diaries/createADiary/3653956596');

    // Diary 데이터를 Map 형식으로 작성
    final Map<String, dynamic> diaryData = {
      'font': font,
      'title': title,
      'content': content,
    };
    print(diaryData);
    setState(() {
      isLoading = true; // 요청 시작 시 로딩 상태로 변경
    });

    // POST 요청
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(diaryData), // Diary 데이터를 JSON으로 인코딩하여 전송
    );

    if (response.statusCode == 200) {
      // 성공적으로 전송된 경우
      print('일기를 성공적으로 저장했습니다!');

      final responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> responseData = jsonDecode(responseBody);

      // 서버에서 받은 output을 저장
      setState(() {
        output = responseData['analyze_question'];
        isLoading = false; // 요청이 끝나면 로딩 상태 해제
        isSaved = true;
      });
    } else {
      // 오류 발생 시 예외 처리
      throw Exception('Failed to post diary');
    }
  }

  // 버튼 클릭 시 실행될 메서드
  void _onPostDiaryButtonPressed() async {
    String font = 'Pretendard'; // 기본 글꼴
    String title = titleController.text; // 사용자가 입력한 제목
    String content = contentController.text; // 사용자가 입력한 내용

    try {
      await postDiary(
        font: font,
        title: title,
        content: content,
      );

      // 성공적으로 POST
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일기를 성공적으로 저장했습니다!')),
      );
    } catch (e) {
      // 오류 발생
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일기 저장에 실패했습니다.')),
      );
    }
  }

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
          isSaved
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: sub3,
                  ),
                )
              : Wrap(
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          _onPostDiaryButtonPressed();
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
                                      // 로딩 중일 때
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
                                      // 로딩 끝나고 결과
                                      : output != null
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
                                                      '오늘의 일기 분석 📖',
                                                      style: TextStyle(
                                                        color: sub1,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    style: ListTileStyle.list,
                                                    subtitle: Text(
                                                      output,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: primary.withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Text(
                                                  '분석에 실패했습니다. 다시 시도 하여 주세요!'),
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
