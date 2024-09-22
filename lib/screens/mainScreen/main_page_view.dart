import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/custom_icons.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/mainScreen/calendar_screen.dart';
import 'package:frontend/screens/mainScreen/home_screen.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 1;
  int length = 4;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 1);
    _tabController = TabController(length: length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: const <Widget>[
              CalendarScreen(),
              HomeScreen(),
              Center(
                child: Text(
                  'Second Page',
                ),
              ),
              Center(
                child: Text(
                  'Third Page',
                ),
              ),
            ],
          ),
          BottomNavigatorBarCustom(
            length: length,
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          ),
        ],
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}

class BottomNavigatorBarCustom extends StatelessWidget {
  const BottomNavigatorBarCustom({
    super.key,
    required this.length,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
  });

  final int length;
  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 852;
    final double width = MediaQuery.of(context).size.width / 393;

    return Container(
      height: 101 * height,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: sub4,
                highlightColor: sub4,
                onTap: () {
                  if (currentPageIndex == 0) {
                    return;
                  }
                  onUpdateCurrentPageIndex(0);
                },
                child: Ink(
                  width: 60 * width,
                  height: 70 * height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(
                        CustomIcons.calendar,
                        size: 24,
                        color: currentPageIndex == 0 ? primary : sub4,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      NavigatorBarText(
                        text: '캘린더',
                        isSelected: currentPageIndex == 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: sub4,
                highlightColor: sub4,
                onTap: () {
                  if (currentPageIndex == 1) {
                    return;
                  }
                  onUpdateCurrentPageIndex(1);
                },
                child: Ink(
                  width: 60 * width,
                  height: 70 * height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(
                        CustomIcons.home,
                        size: 24,
                        color: currentPageIndex == 1 ? primary : sub4,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      NavigatorBarText(
                        text: '홈',
                        isSelected: currentPageIndex == 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: sub4,
                highlightColor: sub4,
                onTap: () {
                  if (currentPageIndex == 2) {
                    return;
                  }
                  onUpdateCurrentPageIndex(2);
                },
                child: Ink(
                  width: 60 * width,
                  height: 70 * height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(
                        CustomIcons.chat_bubble,
                        size: 24,
                        color: currentPageIndex == 2 ? primary : sub4,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      NavigatorBarText(
                        text: '채팅',
                        isSelected: currentPageIndex == 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                splashColor: sub4,
                highlightColor: sub4,
                onTap: () {
                  if (currentPageIndex == 3) {
                    return;
                  }
                  onUpdateCurrentPageIndex(3);
                },
                child: Ink(
                  width: 60 * width,
                  height: 70 * height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(
                        CustomIcons.profile,
                        size: 24,
                        color: currentPageIndex == 3 ? primary : sub4,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      NavigatorBarText(
                        text: '마이페이지',
                        isSelected: currentPageIndex == 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigatorBarText extends StatelessWidget {
  String text;
  final bool isSelected;

  NavigatorBarText({
    super.key,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: isSelected ? primary : sub4,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
