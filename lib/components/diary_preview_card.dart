import 'package:card_swiper/card_swiper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/custom_dialog.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/writingScreen/writing_screen.dart';
import 'package:http/http.dart';

class DiaryPreviewCard extends StatefulWidget {
  DiaryPreviewCard({
    super.key,
    required this.id,
  });

  int id;

  @override
  State<DiaryPreviewCard> createState() => _DiaryPreviewCardState();
}

class _DiaryPreviewCardState extends State<DiaryPreviewCard> {
  final List<String> items = [
    "Card 1",
    "Card 2",
    "Card 3",
    "Card 4",
    "Card 5",
  ];
  List<bool> isBookMarked = List.generate(5, (index) => false);

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
          int selectedIndx =
              (widget.id >= items.length) ? items.length - 1 : widget.id;

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
                        itemCount: items.length,
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
                            color: emGreen,
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
                                        '2024년 12월 28일',
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
                                      '1228 일기',
                                      style: TextStyle(
                                        color: sub1,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 18.0),
                                    child: Text(
                                      '오늘은 아침부터 회사에서 중요한 프로젝트 회의가 있어서 긴장된 상태로 시작했다. 회의가 길어졌지만, 팀원들과 열띤 토론을 통해 좋은 결론을 도출해서 안도감과 뿌듯함을 느꼈다. 오후에는 오랜만에 대학 친구를 만나 카페에서 수다를 떨며 옷음이 끊이지 않는 즐거운 시간을 보냈다. 저녁에는 집에서 좋아하는 책을 읽으며 마음의 평온을 찾았고, 피곤하지만 행복한 기분으로 하루를 마무리했다.',
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
                                    '오늘 아침에는 중요한 프로젝트 회의로 긴장 상태였지만, 회의가 성공적으로 끝나면서 안도감과 뿌듯함을 느꼈다. 오후에는 친구와 카페에서 즐거운 시간을 보내며 많이 웃었고, 저녁에는 집에서 책을 읽으며 평온한 시간을 가졌다. 전반적으로, 오늘은 긴장과 안도, 그리고 즐거움과 평온이 공존하는 하루였어.',
                                    softWrap: true,
                                    maxLines: 4,
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
        child: Hero(
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
                            text: 'YYYY년 MM월 DD일\n', // 기본 텍스트
                            style: TextStyle(
                              color: primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ), // 기본 스타일
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Title\n',
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
                          color: primary,
                        ),
                      ],
                    ),
                    Text(
                      '오늘은 오랫동안 기다려온 날이다. 바로 합정에 있는 유명한 까눌레 가게에 가는 날! 요즘 달콤하면서도 쫀득한 디저트에 푹 빠져버렸는데, 특히 까눌레가 마음에 쏙 들었다. 겉은 바삭하고 속은 촉촉한 그 식감이 정말 예술이다. 인터넷에서 맛집을 찾다가 합정에 있는 가게가 유명하다는 걸 알게 되었고, 꼭 가야겠다고 다짐했다.',
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
    );
  }
}
