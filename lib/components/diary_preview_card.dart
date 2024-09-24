import 'package:card_swiper/card_swiper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/custom_dialog.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/models/diary.dart';
import 'package:frontend/screens/writingScreen/writing_screen.dart';
import 'package:frontend/services/diary_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';

class DiaryPreviewCard extends StatefulWidget {
  DiaryPreviewCard({
    super.key,
    required this.id,
    required this.data,
  });

  int id;
  List<Diary> data;

  @override
  State<DiaryPreviewCard> createState() => _DiaryPreviewCardState();
}

class _DiaryPreviewCardState extends State<DiaryPreviewCard> {
  List<String> colors = [
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
    "#FFDBAB",
    "#D0E6C6",
    "#DEF1FA",
    "#FEF1A1",
    "#ECD1FF",
    "#E2E2E2",
    "#FEF1A1",
    "#C3DBFC",
  ];

  List<bool> isBookMarked = List.generate(150, (index) => false);

  final PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          // 내가 누른 아이템 찾기
          int selectedIndx = (widget.id >= widget.data.length)
              ? widget.data.length - 1
              : widget.id;

          showDialog(
            context: context,
            builder: (BuildContext builder) {
              return StatefulBuilder(
                builder: (context, setState) => Hero(
                  tag: widget.id,
                  child: Center(
                    child: SizedBox(
                      height: 550 * height,
                      child: Swiper(
                        itemCount: widget.data.length,
                        viewportFraction: 0.838, // 카드 너비 조정
                        scale: 0.9, // 양옆 카드 크기 조정
                        scrollDirection: Axis.horizontal,
                        axisDirection: AxisDirection.left,
                        loop: false,
                        itemHeight: 548 * height,
                        itemWidth: 353 * width,
                        index: selectedIndx,
                        onIndexChanged: (value) {
                          selectedIndx = value; // 바뀔 때 인덱스도 같이 바꿔줌.
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: HexColor(colors[index]),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.data[index].formattedDate,
                                        style: TextStyle(
                                          color: sub1,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.32,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isBookMarked[index] =
                                                    !isBookMarked[index];
                                              });
                                            },
                                            child: Icon(
                                              Icons.bookmark,
                                              color: isBookMarked[index]
                                                  ? sub1
                                                  : sub1.withOpacity(0.3),
                                              size: 24,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTapUp: (details) {
                                              double dx =
                                                  details.globalPosition.dx;
                                              double dy =
                                                  details.globalPosition.dy;
                                              double popupWidth = 160 * width;
                                              double popupHeight = 21 * height;
                                              showMenu(
                                                context: context,
                                                position: RelativeRect.fromLTRB(
                                                  dx - 170, // X 좌표
                                                  dy + 15, // Y 좌표 (아이콘 아래로 위치)
                                                  dx + popupWidth, // X 끝점
                                                  dy + popupHeight, // Y 끝점
                                                ),
                                                color: Colors.white,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                items: [
                                                  PopupMenuItem<String>(
                                                    child: SizedBox(
                                                      width: popupWidth,
                                                      height: popupHeight,
                                                      child: const Text(
                                                        '수정',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push<void>(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const WritingScreen(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  PopupMenuItem<String>(
                                                    child: SizedBox(
                                                      width: popupWidth,
                                                      height: popupHeight,
                                                      child: const Text(
                                                        '삭제',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 255, 73, 73),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () => showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return StatefulBuilder(
                                                          builder: (context,
                                                                  setState) =>
                                                              CustomDialog(
                                                            title: Text.rich(
                                                              TextSpan(
                                                                text: '일기를 ',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                children: <TextSpan>[
                                                                  TextSpan(
                                                                    text: '삭제',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          primary,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  const TextSpan(
                                                                    text:
                                                                        '하실 건가요?',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            center:
                                                                '삭제한 내용은 복구할 수 없습니다.',
                                                            lfText: '취소',
                                                            rtText: '삭제',
                                                            lfTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              print('qorhvk');
                                                            },
                                                            rtTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                            child: Icon(
                                              Icons.more_vert,
                                              color: sub1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      widget.data[index].title,
                                      style: TextStyle(
                                        color: sub1,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    child: Text(
                                      widget.data[index].content,
                                      softWrap: true,
                                      maxLines: 11,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    child: Text(
                                      '오늘의 일기 분석 📖',
                                      style: TextStyle(
                                        color: sub1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.data[index].output,
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: sub3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: StatefulBuilder(
          builder: (context, setState) => Hero(
            tag: widget.id,
            child: AspectRatio(
              aspectRatio: 3 / 1,
              child: Card(
                color: sub5,
                shadowColor:
                    const Color.fromARGB(255, 157, 169, 204).withOpacity(0.15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            TextSpan(
                              //text: '${items[widget.id]['date']}\n', // 기본 텍스트
                              text: '${widget.data[widget.id].formattedDate}\n',
                              style: TextStyle(
                                color: primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ), // 기본 스타일
                              children: <TextSpan>[
                                TextSpan(
                                  //text: '${items[widget.id]['title']}\n',
                                  text: '${widget.data[widget.id].title}\n',
                                  style: TextStyle(
                                    color: sub1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 2,
                                  ), // 굵은 텍스트
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.bookmark,
                            // color: isBookMarked[widget.id]
                            color: widget.data[widget.id].bookmark
                                ? primary
                                : Colors.transparent,
                          ),
                        ],
                      ),
                      Text(
                        //'${items[widget.id]["content"]}',
                        '${widget.data[widget.id].content}\n',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: sub1.withOpacity(0.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
