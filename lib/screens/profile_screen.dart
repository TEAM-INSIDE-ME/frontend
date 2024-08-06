import 'package:flutter/material.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/profile_name.dart';
import 'package:frontend/screens/profile_birth.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/objects.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  final int _numPages = 3;

  void _goToNextPage() {
    setState(() {
      _selectedIndex = (_selectedIndex + 1) % _numPages;
    });
    _pageController.animateToPage(
      _selectedIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 * height),
        child: AppBar(
          //backgroundColor: bg,
          backgroundColor: const Color.fromRGBO(60, 65, 92, 1),
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
                  child: const Row(
                    children: [
                      OrbBackground(),
                      OrbBackground(),
                      OrbBackground(),
                      OrbBackground(),
                      OrbBackground(),
                      OrbBackground(),
                      OrbBackground(),
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
              name: 'name',
            ),
          ],
        ),
      ),
    );
  }
}
