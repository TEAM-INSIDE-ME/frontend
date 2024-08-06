import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/components/buttons.dart';
import 'package:frontend/components/objects.dart';
import 'package:frontend/models/colors.dart';
import 'package:frontend/screens/success.dart';
import 'package:frontend/test/birth.dart';
import 'package:frontend/test/name.dart';
import 'package:frontend/test/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

const route = ['/', '/C', '/name', '/birth'];
final _navigatorKey = GlobalKey<NavigatorState>();
late String name;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 839;
    final double width = MediaQuery.of(context).size.width / 393;

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
                route[0] == ''
                    ? Container(
                        color: emRed,
                      )
                    : const BackButtonCustom(),
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
      body: Navigator(
        key: _navigatorKey,
        initialRoute: route[0],
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}

MaterialPageRoute _onGenerateRoute(RouteSettings setting) {
  if (setting.name == route[0]) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => B(
              onTap: () => _navigatorKey.currentState?.pushNamed(route[1]),
            ),
        settings: setting);
  } else if (setting.name == route[1]) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => C(
              onTap: () => _navigatorKey.currentState?.pushNamed(route[2]),
            ),
        settings: setting);
  } else if (setting.name == route[2]) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => Name(
              onTap: () {
                _navigatorKey.currentState?.pushNamed(route[3]);
              },
            ),
        settings: setting);
  } else if (setting.name == route[3]) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => Birth(
              onTap: () {
                _navigatorKey.currentState?.pushNamed(route[0]);
              },
              name: '',
            ),
        settings: setting);
  } else {
    throw Exception('Unknown route: ${setting.name}');
  }
}

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.message,
    required this.firstContent,
    required this.secondContent,
  });

  final String message;
  final Widget firstContent;
  final Widget secondContent;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 839;
    final double width = MediaQuery.of(context).size.width / 393;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0 * width),
      child: Column(
        children: [
          Flexible(
            flex: 34,
            fit: FlexFit.tight,
            child: Container(),
          ),
          Flexible(
            flex: 68,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: sub1,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 476,
            fit: FlexFit.tight,
            child: Container(
              child: widget.firstContent,
            ),
          ),
          Flexible(
            flex: 68,
            fit: FlexFit.loose,
            child: widget.secondContent,
          ),
          Flexible(
            flex: 62,
            fit: FlexFit.tight,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class B extends StatelessWidget {
  final onTap;
  const B({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: emYellow,
      child: OutlinedButton(
        onPressed: onTap,
        child: const Text('wtf'),
      ),
    );
  }
}

class C extends StatelessWidget {
  final onTap;
  const C({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: emRed,
      child: OutlinedButton(
        onPressed: onTap,
        child: const Text('omgomgomgomgomgo'),
      ),
    );
  }
}
