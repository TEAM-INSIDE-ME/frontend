import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profile_frequency.dart';
import 'package:frontend/screens/profile_job.dart';
import 'package:frontend/screens/profile_name.dart';
import 'package:frontend/screens/profile_birth.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/screens/profile_password.dart';
import 'package:frontend/screens/profile_reason.dart';
import 'package:frontend/screens/profile_reminder.dart';
import 'package:frontend/utils/info_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 393;
    final double height = MediaQuery.of(context).size.height / 839;
    final textProvider = Provider.of<InfoProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 * height),
        child: AppBar(
          backgroundColor: bg,
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
                  width: 7,
                ),
                Container(
                  height: 48,
                  width: 306,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(244, 246, 253, 0.5),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      OrbBackground(
                        marble: _selectedIndex >= 0
                            ? Image.asset(
                                'assets/images/marbles/red_marble.png')
                            : Container(),
                      ),
                      OrbBackground(
                        marble: _selectedIndex >= 1
                            ? Image.asset(
                                'assets/images/marbles/orange_marble.png')
                            : Container(),
                      ),
                      OrbBackground(
                        marble: _selectedIndex >= 2
                            ? Image.asset(
                                'assets/images/marbles/yellow_marble.png')
                            : Container(),
                      ),
                      OrbBackground(
                        marble: _selectedIndex >= 3
                            ? Image.asset(
                                'assets/images/marbles/green_marble.png')
                            : Container(),
                      ),
                      OrbBackground(
                        marble: _selectedIndex >= 4
                            ? Image.asset(
                                'assets/images/marbles/blue_marble.png')
                            : Container(),
                      ),
                      OrbBackground(
                        marble: _selectedIndex >= 5
                            ? Image.asset(
                                'assets/images/marbles/navy_marble.jpeg')
                            : Container(),
                      ),
                      OrbBackground(
                        marble: _selectedIndex >= 6
                            ? Image.asset(
                                'assets/images/marbles/purple_marble.png')
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
              name: textProvider.name,
            ),
            ProfileJob(
              onTap: _goToNextPage,
            ),
            ProfileReason(
              onTap: _goToNextPage,
            ),
            ProfileReminder(
              onTap: _goToNextPage,
            ),
            ProfileFreq(
              onTap: _goToNextPage,
            ),
            ProfilePassword(
              onTap: _goToNextPage,
            ),
          ],
        ),
      ),
    );
  }
}
