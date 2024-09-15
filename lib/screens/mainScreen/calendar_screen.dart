import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/writingScreen/writing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String textContent = "";
  String? _savedResolution;
  TextEditingController textController = TextEditingController();

  // calendar 관련 변수들
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _loadResolution();
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

  // 달력의 주 별로 계산하는 함수
  List<List<DateTime>> _getWeeksInMonth(DateTime focusedDay) {
    final lastDayOfMonth =
        DateTime(focusedDay.year, focusedDay.month + 1, 0); // 달의 마지막 날

    List<DateTime> dayInMonth = [];
    for (int i = 0; i < lastDayOfMonth.day; i++) {
      dayInMonth.add(DateTime(
          focusedDay.year, focusedDay.month, i + 1)); // 모든 날짜를 list 에 저장
    }

    List<List<DateTime>> weeks = [];
    List<DateTime> currentWeek = [];

    for (DateTime day in dayInMonth) {
      currentWeek.add(day);
      if (day.weekday == DateTime.saturday || day == lastDayOfMonth) {
        weeks.add(currentWeek);
        currentWeek = [];
      }
    }

    return weeks;
  }

  // 오늘의 다짐 있으면 로드
  Future<void> _loadResolution() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedResolution = prefs.getString('resolution');
      textController.text = _savedResolution ?? '';
    });
  }

  // textfield에서 입력 받아서 저장
  Future<void> _saveResolution() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('resolution', textController.text);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70 * height,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SizedBox(
                height: 50 * height,
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        '2024년 9월',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: sub1,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 24,
                        color: sub4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: resolutionField(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10), // 달력 모서리 둥글게
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: TableCalendar(
                  locale: 'ko-KR',
                  daysOfWeekHeight: 40,
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2023, 9, 13),
                  lastDay: DateTime.utc(2030, 10, 10),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      //_selectedDay = selectedDay; // 선택 막아놓음
                      _focusedDay = focusedDay; // 포커스 데이 업데이트
                    });
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarBuilders: CalendarBuilders(
                    // 디폴트 값 셀 빌더
                    defaultBuilder: (context, day, focusedDay) {
                      int weekday = day.weekday; // 요일 가져오기
                      // divider indent 값 설정
                      double? indent =
                          weekday == DateTime.sunday ? 12 * width : 0;
                      double? endIndent =
                          weekday == DateTime.saturday ? 12 * width : 0;

                      final weeksInMonth = _getWeeksInMonth(focusedDay);
                      final lastWeek = weeksInMonth.last; // 마지막 주

                      // 현재 날짜가 마지막 주인지 확인
                      bool isInLastRow = lastWeek.any(
                        (lastDay) =>
                            lastDay.year == day.year &&
                            lastDay.month == day.month &&
                            lastDay.day == day.day,
                      );

                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                color: sub3,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    child: const Text('머어쩌라구!'),
                                  ),
                                );
                              },
                            ),
                            child: MarbleBackground(
                              radius: 38,
                              // 구슬 색 임의로 지정 추후 수정
                              marble: day.day == 4
                                  ? Marble(
                                      marbleName: 'purple_marble_1',
                                    )
                                  : day.day == 8
                                      ? Marble(marbleName: 'green_marble_1')
                                      : day.day == 9
                                          ? Marble(marbleName: 'navy_marble_1')
                                          : day.day == 10
                                              ? Marble(
                                                  marbleName: 'yellow_marble_1')
                                              : day.day == 13
                                                  ? Marble(
                                                      marbleName:
                                                          'purple_marble_1')
                                                  : Container(),
                            ),
                          ),
                          if (!isInLastRow) // 마지막 주는 divider 없음
                            Divider(
                              color: sub5,
                              indent: indent,
                              endIndent: endIndent,
                              thickness: 1,
                            ),
                        ],
                      );
                    },
                    // 선택된 셀 빌드
                    selectedBuilder: (context, day, focusedDay) {
                      int weekday = day.weekday; // 요일 가져오기
                      // divider indent 값 설정
                      double? indent =
                          weekday == DateTime.sunday ? 12 * width : 0;
                      double? endIndent =
                          weekday == DateTime.saturday ? 12 * width : 0;

                      final weeksInMonth = _getWeeksInMonth(focusedDay);
                      final lastWeek = weeksInMonth.last; // 마지막 주

                      // 현재 날짜가 마지막 주인지 확인
                      bool isInLastRow = lastWeek.any(
                        (lastDay) =>
                            lastDay.year == day.year &&
                            lastDay.month == day.month &&
                            lastDay.day == day.day,
                      );
                      return Column(
                        children: [
                          if (!isInLastRow) // 마지막 주는 divider 없음
                            Divider(
                              color: sub5,
                              indent: indent,
                              endIndent: endIndent,
                              thickness: 1,
                            ),
                        ],
                      );
                    },
                    todayBuilder: (context, day, focusedDay) {
                      int weekday = day.weekday; // 요일 가져오기
                      // divider indent 값 설정
                      double? indent =
                          weekday == DateTime.sunday ? 12 * width : 0;
                      double? endIndent =
                          weekday == DateTime.saturday ? 12 * width : 0;

                      final weeksInMonth = _getWeeksInMonth(focusedDay);
                      final lastWeek = weeksInMonth.last; // 마지막 주

                      // 현재 날짜가 마지막 주인지 확인
                      bool isInLastRow = lastWeek.any(
                        (lastDay) =>
                            lastDay.year == day.year &&
                            lastDay.month == day.month &&
                            lastDay.day == day.day,
                      );
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(0),
                            width: 20 * width,
                            height: 20 * height,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: emBlue,
                            ),
                            child: Text(
                              '${day.day}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          MarbleBackground(
                            radius: 38,
                            marble: IconButton(
                              onPressed: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const WritingScreen(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.add,
                                color: sub3,
                              ),
                            ),
                          ),
                          if (!isInLastRow) // 마지막 주는 divider 없음
                            Divider(
                              color: sub5,
                              indent: indent,
                              endIndent: endIndent,
                              thickness: 1,
                            ),
                        ],
                      );
                    },
                    outsideBuilder: (context, day, focusedDay) {
                      return null;
                    },
                  ),
                  headerVisible: false,
                  rowHeight: 80 * height,
                  // 상단 요일 텍스트 스타일 지정
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: sub4,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    weekendStyle: TextStyle(
                      color: sub4,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    // 달력 스타일
                    defaultTextStyle: TextStyle(
                      // 평일  숫자 텍스트 스타일
                      color: sub3,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    weekendTextStyle: TextStyle(
                      // 주말 숫자 텍스트 스타일
                      color: sub3,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    todayTextStyle: const TextStyle(
                      // 오늘 숫자 텍스트 스타일
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    todayDecoration: BoxDecoration(
                      color: emBlue,
                      shape: BoxShape.circle,
                    ),
                    holidayTextStyle: TextStyle(
                      color: sub4,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    outsideDaysVisible: false, // 다음 달 날짜 표시 여부
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 64 * height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // 각각 가운데 정렬
                    children: [
                      Text(
                        "전체 기록 보기",
                        style: TextStyle(
                          color: sub3,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      VerticalDivider(
                        // 세로 선 긋기
                        width: 1,
                        indent: 12 * height, // 위 아래 간격 두기
                        endIndent: 12 * height,
                        color: sub4,
                      ),
                      Text(
                        "지날 달 보고서",
                        style: TextStyle(
                          color: sub3,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //  bottom navigation bar 자리 남겨둠
            Container(
              height: 101 * height,
            ),
          ],
        ),
      ),
    );
  }

  TextField resolutionField() {
    return TextField(
      controller: textController,
      focusNode: _focusNode,
      style: TextStyle(
        color: sub1,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.edit_outlined,
          color: sub3.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.fromLTRB(12, 15, 15, 0),
        hintText: '이번 달 다짐을 적어보세요!',
        hintStyle: TextStyle(
          color: sub4,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
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
          _saveResolution();
        });
      },
    );
  }
}
