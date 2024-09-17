import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/custom_dialog.dart';
import 'package:frontend/components/diary_preview_card.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/writingScreen/writing_screen.dart';
import 'package:http/http.dart';

class WholeViewScreen extends StatefulWidget {
  const WholeViewScreen({super.key});

  @override
  State<WholeViewScreen> createState() => _WholeViewScreenState();
}

class _WholeViewScreenState extends State<WholeViewScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String textContent = "";
  TextEditingController textController = TextEditingController();
  int diary_cnt = 5; // 일기 갯수 초기화
  List<String> items = ['최신순', '날짜순', '북마크'];
  String onSelectedItem = '최신순';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: Border(
          bottom: BorderSide(
            width: 1,
            color: sub5,
          ),
        ),
        title: searchField(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(109.0), // 높이 지정
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      '$diary_cnt개의 일기',
                      style: TextStyle(
                        color: sub1,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 25,
                    ),
                  ],
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    items: items
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 18,
                                  color: onSelectedItem == e
                                      ? sub1
                                      : Colors.transparent,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(e),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        onSelectedItem = value!;
                      });
                    },
                    iconStyleData: IconStyleData(
                      icon: Row(
                        children: [
                          Text(
                            onSelectedItem,
                            style: TextStyle(
                              color: primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.swap_vert,
                            color: primary,
                          ),
                        ],
                      ),
                    ),
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 40 * height,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: 215 * width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: const Color.fromARGB(255, 157, 169, 204)
                                .withOpacity(0.1),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0.0, 2.0),
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      elevation: 4,
                      offset: const Offset(-80, 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: sub3,
        ),
      ),
      body: ListView.builder(
        itemCount: diary_cnt,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return DiaryPreviewCard(id: index);
        },
        // padding: const EdgeInsets.all(10),
      ),
    );
  }

  TextField searchField() {
    return TextField(
      controller: textController,
      focusNode: _focusNode,
      style: TextStyle(
        color: sub1,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: sub3.withOpacity(0.5),
        ),
        suffixIcon: textController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  setState(() {
                    textController.clear();
                  });
                },
                icon: Icon(
                  Icons.clear,
                  color: sub3.withOpacity(0.5),
                ),
              )
            : null,
        contentPadding: const EdgeInsets.fromLTRB(12, 15, 15, 0),
        hintText: '날짜 또는 키워드를 입력하세요',
        hintStyle: TextStyle(
          color: sub4,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: sub5,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        counterText: '',
      ),
      maxLength: 20,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      cursorColor: sub2,
      cursorHeight: 19,
      cursorWidth: 1.5,
      autofocus: false,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: (value) {
        setState(() {
          textContent = textController.text;
        });
      },
    );
  }
}
