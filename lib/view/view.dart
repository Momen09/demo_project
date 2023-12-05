// import 'package:demo_project/model/api_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../viewmodel/api_viewmodel.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ApiModel(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
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
