// // main.dart
// import 'package:demo_project/model/user_events_viewmodel.dart';
// import 'package:demo_project/viewmodel/user_events_viewmodel.dart';
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
import 'package:demo_project/view/map_widget.dart';
import 'package:demo_project/view/my_home_page.dart';
import 'package:demo_project/view/reservation.dart';
import 'package:demo_project/viewmodel/api_viewmodel.dart';
import 'package:demo_project/viewmodel/current_pos_viewmodel.dart';
import 'package:demo_project/viewmodel/tracking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'constants/connectivity.dart';
import 'constants/enum.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReservationViewModel()),
        ChangeNotifierProvider(create: (_) => TrackingViewModel()),

        StreamProvider(
            create: (context) => NetworkService().controller.stream,
            initialData: NetworkStatus.online)
      ],
      child: AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
        ),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
            theme: theme,
            darkTheme: darkTheme,
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
            routes: {
              ReservationScreen.routeName: (context) =>
              const ReservationScreen(),
              MapWidget.routeName: (context) =>
               MapWidget(),
            }
        ),
      ),
    );
  }
}
