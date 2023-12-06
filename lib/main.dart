// // main.dart
// import 'package:demo_project/model/api_model.dart';
// import 'package:demo_project/viewmodel/api_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
//       .then((_) => runApp(MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_)=> ApiModel())
//       ],
//       child: MaterialApp(
//         home: MyHomePage(),
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<UserEventsViewModel>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Events Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 viewModel.fetchUserEvents('your_refresh_token_here');
//                 print(viewModel.fetchUserEvents);
//               },
//               child: Text('Fetch User Events'),
//             ),
//             SizedBox(height: 20),
//             if (viewModel.userEvents.isNotEmpty)
//               Text('User Events: ${viewModel.userEvents.toString()}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:demo_project/model/api_model.dart';
import 'package:demo_project/view/my_home_page.dart';
import 'package:demo_project/viewmodel/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, ThemeViewModel, d) {
          return AdaptiveTheme(
          light: ThemeData(
            brightness: Brightness.light,
          ),
          dark: ThemeData(
            brightness: Brightness.dark,
          ),
          initial:ThemeViewModel.isDarkMode? AdaptiveThemeMode.light:AdaptiveThemeMode.dark,
          builder: (theme, darkTheme) => MaterialApp(
            theme: theme,
            darkTheme: darkTheme,
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
          ),
        );
          },
      ),
    );
  }
}
