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
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/services/database_service.dart';
import 'package:demo_project/view/map_widget.dart';
import 'package:demo_project/view/my_home_page.dart';
import 'package:demo_project/view/osm_map.dart';
import 'package:demo_project/view/pdf/pdf_screen.dart';
import 'package:demo_project/view/pdf/signature_widget.dart';
import 'package:demo_project/view/reservation.dart';
import 'package:demo_project/view/todo/TodoScreen.dart';
import 'package:demo_project/view/todo/todo_details.dart';
import 'package:demo_project/viewmodel/TodoViewModel.dart';
import 'package:demo_project/viewmodel/api_viewmodel.dart';
import 'package:demo_project/viewmodel/firebase_api_viewmodel.dart';
import 'package:demo_project/viewmodel/pdf_viewmodel.dart';
import 'package:demo_project/viewmodel/tracking_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'constants/connectivity.dart';
import 'constants/enum.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAWp-FSKG17W__ptIib7tE6WZRPrKaWtEA',
          appId: '1:811505743152:android:e6c9d5324b8beee02584f5',
          messagingSenderId: '811505743152',
          projectId: 'fir-43577'));
   FirebaseApi().initNotifications();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'basic notification',
        channelDescription: 'test notification channel'),
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'basic group'),
  ]);
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
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
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
        ChangeNotifierProvider(create: (_) => NetworkService()),
        ChangeNotifierProvider(create: (_) => PdfViewModel()),




        // ChangeNotifierProvider(create: (_) => DataBaseService()),

        // ChangeNotifierProvider(create: (_) => FirebaseApi()),
        StreamProvider(
            create: (context) => NetworkService().networkStatusStream,
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
            home:  const MyHomePage(),
            debugShowCheckedModeBanner: false,
            routes: {
              ReservationScreen.routeName: (context) =>
                  const ReservationScreen(),
              MapWidget.routeName: (context) => const MapWidget(),
              TodoScreen.routeName: (context) => const TodoScreen(),
              TodoDetails.routeName: (context) => const TodoDetails(),
              OsmMap.routeName: (context) => const OsmMap(),
              // PDFScreen.routeName: (context) =>  PDFScreen(),
              Viewer.routeName: (context) =>  const Viewer(),

            }),
      ),
    );
  }
}
