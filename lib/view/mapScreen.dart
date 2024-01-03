// import 'package:demo_project/viewmodel/tracking_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/enum.dart';
// import 'loading_screen.dart';
// import 'map_widget.dart';
//
// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});
//   static const routeName = 'MapScreen';
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Consumer<TrackingViewModel>(builder: (context,traking,child){
//         if(traking.viewState == ViewState.loading){
//           return const Center(
//             child: LoadingScreen(),
//           );
//         } if (traking.viewState == ViewState.loaded) {
//           return const MapWidget();
//         } else {
//           return Container();
//         }
//       },),
//     );
//   }
// }
