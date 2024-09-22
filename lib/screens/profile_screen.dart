import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/mainScreen/main_page_view.dart';
import 'package:frontend/screens/mainScreen/home_screen.dart';
import 'package:frontend/screens/profileScreen/profile_frequency.dart';
import 'package:frontend/screens/profileScreen/profile_job.dart';
import 'package:frontend/screens/profileScreen/profile_name.dart';
import 'package:frontend/screens/profileScreen/profile_birth.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/screens/profileScreen/profile_password.dart';
import 'package:frontend/screens/profileScreen/profile_purpose.dart';
import 'package:frontend/screens/profileScreen/profile_reminder.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:frontend/utils/user_auth_manager.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final int initialIndex;
  const ProfileScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final PageController _pageController =
      PageController(initialPage: widget.initialIndex);
  late int _selectedIndex;
  final int _numPages = 7;

  void _goToNextPage() {
    setState(() {
      _selectedIndex = (_selectedIndex + 1) % _numPages;
      print(_selectedIndex);
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    print(_selectedIndex);
  }

  void _goToPreviousPage() {
    setState(() {
      _selectedIndex = (_selectedIndex - 1) % _numPages;
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 * height),
        child: AppBar(
          backgroundColor: bg2,
          //backgroundColor: const Color.fromRGBO(60, 65, 92, 1),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(72 * height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedIndex == 0
                    ? Container(
                        color: emRed,
                      )
                    : BackButtonCustom(
                        onTap: _goToPreviousPage,
                      ),
                Container(
                  width: 7 * width,
                ),
                Container(
                  height: 48 * height,
                  width: 306 * width,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(244, 246, 253, 0.5),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      MarbleBackground(
                        radius: 38,
                        marble: _selectedIndex >= 0
                            ? Marble(
                                marbleName: 'red_marble_1',
                                radius: 38,
                              )
                            : Container(),
                      ),
                      MarbleBackground(
                        radius: 38,
                        marble: _selectedIndex >= 1
                            ? Marble(
                                marbleName: 'orange_marble_1',
                                radius: 38,
                              )
                            : Container(),
                      ),
                      MarbleBackground(
                        radius: 38,
                        marble: _selectedIndex >= 2
                            ? Marble(
                                marbleName: 'yellow_marble_1',
                                radius: 38,
                              )
                            : Container(),
                      ),
                      MarbleBackground(
                        radius: 38,
                        marble: _selectedIndex >= 3
                            ? Marble(
                                marbleName: 'green_marble_1',
                                radius: 38,
                              )
                            : Container(),
                      ),
                      MarbleBackground(
                        radius: 38,
                        marble: _selectedIndex >= 4
                            ? Marble(
                                marbleName: 'blue_marble_1',
                                radius: 38,
                              )
                            : Container(),
                      ),
                      MarbleBackground(
                        radius: 38,
                        marble: _selectedIndex >= 5
                            ? Marble(
                                marbleName: 'navy_marble_1',
                                radius: 38,
                              )
                            : Container(),
                      ),
                      MarbleBackground(
                        radius: 38,
                        marble: _selectedIndex >= 6
                            ? Marble(
                                marbleName: 'purple_marble_1',
                                radius: 38,
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            ProfileName(
              onTap: _goToNextPage,
            ),
            ProfileBirth(
              onTap: _goToNextPage,
            ),
            ProfileJob(
              onTap: _goToNextPage,
            ),
            ProfilePurpose(
              onTap: _goToNextPage,
            ),
            ProfileReminder(
              onTap: _goToNextPage,
            ),
            ProfileFreq(
              onTap: _goToNextPage,
            ),
            ProfilePassword(
              onTap: () {
                postUserInfo(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
