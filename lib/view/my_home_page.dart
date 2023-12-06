import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/theme_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeViewModel>(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SwitchListTile(
              activeThumbImage:
              const AssetImage('assets/images/img.png'),
              inactiveThumbImage:
                  const AssetImage('assets/images/icons8-dark-mode-30.png'),
              // activeColor: Theme.of(context).scaffoldBackgroundColor,
              value: themeMode.isDarkMode,
              title: const Text(
                'THEME',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              secondary: const Icon(
                Icons.dark_mode_outlined,
                color: Colors.white,
                // size: 50,
              ),
              onChanged: (bool value) {
                setState(() {
                  themeMode.toggleTheme(value);
                });
              }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      // primary: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      'OPEN RESERVATION',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade900,
                    // primary: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text(
                    'SHOW IOS TICKET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade900,
                    // primary: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text(
                    'SHOW ANDROID TICKET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
