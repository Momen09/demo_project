import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/view/reservation.dart';
import 'package:demo_project/view/view.dart';
import 'package:demo_project/viewmodel/api_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/K_Network.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final apiViewModel = Provider.of<ApiViewModel>(context);
    final bool _isDark = AdaptiveTheme.of(context).isDefault;
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
              return SwitchListTile(
                  activeThumbImage: const AssetImage('assets/images/img.png'),
                  inactiveThumbImage:
                      const AssetImage('assets/images/icons8-dark-mode-30.png'),
                  // activeColor: Theme.of(context).scaffoldBackgroundColor,
                  value: AdaptiveTheme.of(context).mode.isDark,
                  title: Text(
                    'THEME',
                    style: TextStyle(
                      color: _isDark ? Colors.black : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  secondary: Icon(
                    _isDark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    color: _isDark ? Colors.black : Colors.white,
                    // size: 50,
                  ),
                  onChanged: (value) {
                    setState(() {
                      value
                          ? AdaptiveTheme.of(context).setDark()
                          : AdaptiveTheme.of(context).setLight();
                    });
                  });
            }),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Button1(
                    context,
                    _isDark,
                    size,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  button2(size: size, isDark: _isDark),
                  const SizedBox(
                    height: 10,
                  ),
                  button3(size: size, isDark: _isDark),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

ElevatedButton Button1(BuildContext context, bool _isDark, Size size) {
  return ElevatedButton(
    onPressed: () {

        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ReservationScreen();
            });
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: _isDark ? Colors.black : Colors.white,
      // primary: Colors.white,
      minimumSize: Size.fromHeight(size.height * 0.1),
      side: BorderSide(
        color: _isDark ? Colors.black : Colors.white,
      ),
      shape: const RoundedRectangleBorder(),
    ),
    child: Text(
      'OPEN RESERVATION',
      style: TextStyle(
        color: _isDark ? Colors.white : Colors.black,
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
    final apiViewModel = Provider.of<ApiViewModel>(context);
    return ElevatedButton(
      onPressed: () {
        // print(apiViewModel.reservations.first.endDate.toString());
        // print(apiViewModel.reservations.first.endDate.toString());
        // apiViewModel.reservations.last.stays?.forEach((element) {
        //   if (element.rooms != null && element.rooms!.isNotEmpty) {
        //     print(element.rooms!.last.stayName);
        //   } else {
        //     print('No rooms found for this stay.');
        //   }
        // });
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
  }) : _isDark = isDark;

  final Size size;
  final bool _isDark;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context,AppScreen.routeName);
      },
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
        'SHOW IOS TICKET',
        style: TextStyle(
          color: _isDark ? Colors.black : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
