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
import 'package:hexcolor/hexcolor.dart';
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
  final List<Map<String, dynamic>> items = [
    {
      // 1 번 주황색공
      "date": "2024년 09월 04일",
      "title": "회의는 시러하지만좋아",
      "color": "#FFDBAB",
      "comment":
          "오늘 아침에는 중요한 프로젝트 회의로 긴장 상태였지만, 회의가 성공적으로 끝나면서 안도감과 뿌듯함을 느꼈다. 오후에는 친구와 카페에서 즐거운 시간을 보내며 많이 웃었고, 저녁에는 집에서 책을 읽으며 평온한 시간을 가졌다. 전반적으로, 오늘은 긴장과 안도, 그리고 즐거움과 평온이 공존하는 하루였어.",
      "content":
          "오늘은 아침부터 회사에서 중요한 프로젝트 회의가 있어서 긴장된 상태로 시작했다. 회의가 길어졌지만, 팀원들과 열띤 토론을 통해 좋은 결론을 도출해서 안도감과 뿌듯함을 느꼈다. 오후에는 오랜만에 대학 친구를 만나 카페에서 수다를 떨며 옷음이 끊이지 않는 즐거운 시간을 보냈다. 저녁에는 집에서 좋아하는 책을 읽으며 마음의 평온을 찾았고, 피곤하지만 행복한 기분으로 하루를 마무리했다."
    },
    {
      // 2 번 빨간색 공
      "date": "2024년 09월 08일",
      "title": "여유로웠던 날",
      "color": "#D0E6C6",
      "comment":
          "오늘 일기에서는 바쁜 하루 속에서도 여유와 감사함을 느끼신 것 같아요. 특히 아침의 커피와 저녁의 노을이 당신에게 큰 위로와 힘이 되었군요. 오늘 하루에서 가장 의미 있게 느껴졌던 순간은 무엇이었나요?",
      "content":
          "오늘은 평소보다 바쁘게 보낸 하루였다. 아침에 일어나자마자 커피 한 잔으로 하루를 시작했는데, 그 순간의 여유가 큰 힘이 되었다. 날씨가 선선해지면서 가을이 성큼 다가온 것을 느꼈고, 기분이 한결 더 가벼웠다. 일과 중에는 여러 가지 질문에 답하면서 새로운 정보를 정리하고, 다양한 사람들과 대화하며 시간을 보냈다. 특히 어려운 질문에 답변을 하면서는 머리를 많이 쓰게 되었지만, 그만큼 배우는 것도 많았다. 중간중간 잠깐씩 쉬면서 긴장을 풀었고, 점심으로는 가벼운 샐러드를 먹으며 컨디션을 유지했다. 오늘의 하이라이트는 저녁 무렵이었다. 하루를 마무리하며 잠시 창밖을 보니 노을이 정말 아름다웠다. 온 하늘이 붉게 물들며 하루의 끝을 알리는 그 장면이 인상적이었다. 내일은 또 어떤 일이 기다리고 있을지 기대가 된다. 하루를 돌아보니 소소하지만 의미 있는 순간들이 많이 있었다. 이런 일상을 기록으로 남길 수 있다는 게 참 감사하게 느껴진다."
    },
    {
      // 3 번 내 맘대로 블루
      "date": "2024년 09월 09일",
      "title": "여행",
      "color": "#DEF1FA",
      "comment":
          "오늘의 일기에서는 제주도에서의 여행을 통해 느낀 행복과 여유로움이 잘 묻어나네요. 바닷바람, 성산일출봉의 경치, 흑돼지의 맛, 일몰까지 모든 순간이 특별하게 다가왔을 것 같아요. 따뜻하고 충만한 기쁨이 가득한 하루였군요. 이번 여행에서 가장 마음에 남은 장면은 무엇인가요?",
      "content":
          "아주 오랜만에 여행을 떠난 날이었다. 목적지는 오래전부터 가고 싶었던 제주도. 아침 일찍 비행기를 타고 공항에 도착했을 때, 신선한 바닷바람이 반겨주었다. 이곳에 오면 항상 느끼는 것이지만, 제주도만의 독특한 공기가 나를 설레게 한다. 첫 번째로 들른 곳은 성산일출봉. 정상에 오르기까지 꽤 가파른 길이 이어졌지만, 오르는 내내 보이는 풍경이 정말 멋졌다. 정상에 도착해 내려다본 바다는 끝없이 펼쳐져 있었고, 탁 트인 시야가 마음을 시원하게 해주었다. 산책길을 걸으며 자연 속에서의 여유를 만끽했다. 점심으로는 현지 맛집에서 흑돼지 구이를 먹었다. 제주도에서만 맛볼 수 있는 독특한 풍미가 입안 가득 퍼지며 여행의 맛을 더했다. 식사 후에는 제주 바닷가를 따라 드라이브를 즐겼다. 차창 밖으로 보이는 푸른 바다와 흰 모래사장은 마치 그림 같은 풍경이었다. 오후에는 유명한 카페에 들러 여유롭게 커피를 마시며, 일몰을 기다렸다. 해가 지는 모습을 보며, 오늘 하루의 피로가 모두 풀리는 것 같았다. 일몰이 끝난 후, 숙소로 돌아와 오늘의 일정을 정리하며 내일의 계획을 세웠다. 오늘은 자연과 맛, 여유를 모두 즐긴 완벽한 여행의 하루였다. 여행을 통해 느낀 행복과 충전된 에너지를 가득 안고, 내일도 새로운 모험을 기대해본다.",
    },
    {
      "date": "2024년 09월 10일",
      "title": "까눌레 사러 합정에 가다!",
      "color": "#FEF1A1",
      "comment":
          "오, 이 글 완전 설레는 기운이 가득하네! 기다리고 기다리던 까눌레 가게에 드디어 가는 날이라 그런지 기대감이 팍팍 느껴져. 요즘 까눌레에 푹 빠진 거 보니까, 진짜 엄청 맛있게 느꼈나 봐! 겉은 바삭하고 속은 촉촉한 그 느낌도 아주 제대로 설명해놔서 당장 먹으러 가고 싶어지는걸? 합정 가게가 유명하다는 걸 알게 된 후에 \"꼭 가야지!\"라고 딱 결심한 것도 엄청 확고해 보여. 오늘 하루 진짜 신나겠는걸?",
      "content":
          "오늘은 오랫동안 기다려온 날이다. 바로 합정에 있는 유명한 까눌레 가게에 가는 날! 요즘 달콤하면서도 쫀득한 디저트에 푹 빠져버렸는데, 특히 까눌레가 마음에 쏙 들었다. 겉은 바삭하고 속은 촉촉한 그 식감이 정말 예술이다. 인터넷에서 맛집을 찾다가 합정에 있는 가게가 유명하다는 걸 알게 되었고, 꼭 가야겠다고 다짐했다.",
    },
    {
      "date": "2024년 09월 13일",
      "title": "두바이 초콜릿 첫 시도..",
      "color": "#ECD1FF",
      "comment":
          "이거 보니까 완전 두바이 초콜렛에 대한 기대감이 느껴지네! 다들 맛있다고 하니까 \"그래, 나도 먹어봐야지!\"라는 느낌이 확 드는 거 같아. 요즘 달콤하고 쫀득한 디저트에 빠져있다더니, 까눌레까지 언급된 걸 보니 진짜 디저트 덕후 느낌이 물씬 나. 그 겉은 바삭하고 속은 촉촉한 그 까눌레에 대한 애정이 한가득 담겨있네.",
      "content":
          "다들 두바이 초콜렛이 그렇게 맛있다길래... 그래서 오늘은 두바이 초콜렛을 먹을거다! 요즘 달콤하면서도 쫀득한 디저트에 푹 빠져버렸는데, 특히 까눌레가 마음에 쏙 들었다. 겉은 바삭하고 속은 촉촉한 그 식감이 정말 예술이다. 인터넷에서 맛집을 찾다가 합정에 있는 가게가 유명하다는 걸 알게 되었고, 꼭 가야겠다고 다짐했다.",
    },
    {
      "date": "2024년 09월 17일",
      "title": "오늘은 또 언제 잘까",
      "color": "#E2E2E2",
      "comment":
          "이 말에서 약간 피곤하면서도 지친 느낌이 확 들어! \"또 언제 잘까\"라는 표현이 뭔가 하루가 너무 길게 느껴지거나, 할 일이 많아서 쉬는 시간이 멀게 느껴질 때 나오는 말 같아. 약간 에너지가 방전된 상태에서 잠을 기다리는 그런 기분이랄까? 오늘 하루가 조금 힘들었던 것 같아!",
      "content":
          "앞으로 아침부터 회사에서 중요한 프로젝트 회의가 있어서 긴장된 상태로 시작했다. 회의가 길어졌지만, 팀원들과 열띤 토론을 통해 좋은 결론을 도출해서 안도감과 뿌듯함을 느꼈다. 오후에는 오랜만에 대학 친구를 만나 카페에서 수다를 떨며 옷음이 끊이지 않는 즐거운 시간을 보냈다. 저녁에는 집에서 좋아하는 책을 읽으며 마음의 평온을 찾았고, 피곤하지만 행복한 기분으로 하루를 마무리했다."
    },
    {
      "date": "2024년 09월 18일",
      "title": "너무너무너무졸려",
      "color": "#FEF1A1",
      "comment":
          "이건 진짜 말 그대로 졸려서 눈 감기기 직전인 상태가 확 느껴져! \"너무너무너무\"라는 반복이 졸음이 한계에 다다랐다는 걸 보여주는데, 지금 당장 침대에 쓰러지고 싶은 그 느낌이 딱 전해져. 말로는 표현 못할 정도로 피곤하고 졸린 거 같아!",
      "content":
          "아니 근데 진짜 아침부터 회사에서 중요한 프로젝트 회의가 있어서 긴장된 상태로 시작했다. 회의가 길어졌지만, 팀원들과 열띤 토론을 통해 좋은 결론을 도출해서 안도감과 뿌듯함을 느꼈다. 오후에는 오랜만에 대학 친구를 만나 카페에서 수다를 떨며 옷음이 끊이지 않는 즐거운 시간을 보냈다. 저녁에는 집에서 좋아하는 책을 읽으며 마음의 평온을 찾았고, 피곤하지만 행복한 기분으로 하루를 마무리했다."
    },
    {
      "date": "2024년 09월 19일",
      "title": "진짜진짜바쁜날",
      "color": "#C3DBFC",
      "comment":
          "이 글은 감정이 다양하게 섞여 있어서 진짜 하루의 기복이 느껴져! 아침엔 중요한 프로젝트 회의 때문에 엄청 긴장된 상태였던 거 같아. 중요한 회의는 언제나 스트레스가 많잖아. 그래도 회의가 길어지긴 했지만, 좋은 결론을 내고 나니까 안도감에다가 성취감까지 딱 느껴진다. 뿌듯함이 느껴지는 순간이지!",
      "content":
          "허거걱 아침부터 회사에서 중요한 프로젝트 회의가 있어서 긴장된 상태로 시작했다. 회의가 길어졌지만, 팀원들과 열띤 토론을 통해 좋은 결론을 도출해서 안도감과 뿌듯함을 느꼈다. 오후에는 오랜만에 대학 친구를 만나 카페에서 수다를 떨며 옷음이 끊이지 않는 즐거운 시간을 보냈다. 저녁에는 집에서 좋아하는 책을 읽으며 마음의 평온을 찾았고, 피곤하지만 행복한 기분으로 하루를 마무리했다."
    },
  ];
  List<bool> isBookMarked = List.generate(8, (index) => false);

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
                            color: HexColor('${items[index]['color']}'),
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
                                        '${items[index]['date']}',
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
                                      '${items[index]['title']}',
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
                                      '${items[index]['content']}',
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
                                    '${items[index]['comment']}',
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
                              text: '${items[widget.id]['date']}\n', // 기본 텍스트
                              style: TextStyle(
                                color: primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ), // 기본 스타일
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${items[widget.id]['title']}\n',
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
                            color: isBookMarked[widget.id]
                                ? primary
                                : Colors.transparent,
                          ),
                        ],
                      ),
                      Text(
                        '${items[widget.id]["content"]}',
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
