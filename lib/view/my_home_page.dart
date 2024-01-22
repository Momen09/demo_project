import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/view/map_widget.dart';
import 'package:demo_project/view/osm_map.dart';
import 'package:demo_project/view/reservation.dart';
import 'package:demo_project/view/todo/TodoScreen.dart';
import 'package:demo_project/view/widget/notification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart'
    as modal_bottom_sheet;
import '../constants/K_Network.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).isDefault;
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Consumer(builder: (BuildContext context, apiViewModel, T) {
              return _themeWidget(context, isDark);
            }),
            const Spacer(),
            _homeButtons(context, isDark, size)
          ],
        ),
      ),
    );
  }

  Widget _homeButtons(BuildContext context, bool isDark, Size size) {
    return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Button1(
                  context,
                  isDark,
                  size,
                ),
                const SizedBox(
                  height: 10,
                ),
                button2(
                  size: size,
                  isDark: isDark,
                  title: 'SHOW OSM',
                  onPressed: () {
                    Navigator.pushNamed(context, OsmMap.routeName);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                button2(
                  size: size,
                  isDark: isDark,
                  title: 'SHOW MAP',
                  onPressed: () {
                    Navigator.pushNamed(context, MapWidget.routeName);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                button3(size: size, isDark: isDark),
                const NotificationWidget(),
                const Gap(10),
              ],
            ),
          );
  }

  Widget _themeWidget(BuildContext context, bool isDark) {
    return SwitchListTile(
        activeThumbImage: const AssetImage('assets/images/img.png'),
        inactiveThumbImage:
            const AssetImage('assets/images/icons8-dark-mode-30.png'),
        // activeColor: Theme.of(context).scaffoldBackgroundColor,
        value: AdaptiveTheme.of(context).mode.isDark,
        title: Text(
          'THEME',
          style: TextStyle(
            color: isDark ? Colors.black : Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        secondary: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          color: isDark ? Colors.black : Colors.white,
          // size: 50,
        ),
        onChanged: (value) {
          setState(() {
            value
                ? AdaptiveTheme.of(context).setDark()
                : AdaptiveTheme.of(context).setLight();
          });
        });
  }
}

Widget Button1(BuildContext context, bool isDark, Size size) {
  return ElevatedButton(
    onPressed: () {
      modal_bottom_sheet.showCupertinoModalBottomSheet(
          context: context,
          builder: (context) {
            return const ReservationScreen();
          });
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: isDark ? Colors.black : Colors.white,
      // primary: Colors.white,
      minimumSize: Size.fromHeight(size.height * 0.1),
      side: BorderSide(
        color: isDark ? Colors.black : Colors.white,
      ),
      shape: const RoundedRectangleBorder(),
    ),
    child: Text(
      'OPEN RESERVATION',
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class button3 extends StatelessWidget {
  button3({
    super.key,
    required this.size,
    required bool isDark,
  }) : _isDark = isDark;

  final Size size;
  final bool _isDark;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, TodoScreen.routeName);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // primary: Colors.white,
        minimumSize: Size.fromHeight(size.height * 0.1),
        shape: const RoundedRectangleBorder(),
      ),
      child: Text(
        'OPEN ANDROID TICKET',
        style: TextStyle(
          color: _isDark ? Colors.black : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class button2 extends StatelessWidget {
  const button2({
    super.key,
    required this.size,
    required bool isDark,
    required this.title,
    required this.onPressed,
  }) : _isDark = isDark;

  final Size size;
  final bool _isDark;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // primary: Colors.white,
        minimumSize: Size.fromHeight(size.height * 0.1),
        side: BorderSide(
          color: _isDark ? Colors.black : Colors.white,
        ),
        shape: const RoundedRectangleBorder(),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: _isDark ? Colors.black : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
