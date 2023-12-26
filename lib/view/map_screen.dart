// import 'package:demo_project/constants/K_Network.dart';
// import 'package:demo_project/view/loading_screen.dart';
// import 'package:demo_project/viewmodel/current_pos_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';
//
// class MapScreen extends StatefulWidget {
//   MapScreen({super.key});
//
//   static const routeName = 'MapScreen';
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final CurrentPosViewModel _currentPos = CurrentPosViewModel();
//
//
//   // final Location _locationController = Location();
//   // final myPosition = const LatLng(30.0217, 31.4244);
//   // LatLng? _currentPosition = null;
//
//   @override
//   void initState() {
//     _currentPos.getLocationUpdates();
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CurrentPosViewModel>(builder: (context, currentPos, child) {
//       LatLng? currentPosition = _currentPos.currentPosition;
//       return currentPosition == null
//           ? const LoadingScreen()
//           : Scaffold(
//               body: FlutterMap(
//
//                 // mapController: mapController,
//               options: MapOptions(
//                 minZoom: 5,
//                 maxZoom: 25,
//                 initialZoom: 8,
//                 initialCenter: currentPosition!,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                      KNetwork.mapUrl,
//                   additionalOptions: const {
//                     'accessToken': KNetwork.mapToken,
//                     'id': KNetwork.mapId
//                   },
//                 ),
//                 MarkerLayer(markers: [
//                   Marker(
//                     point: currentPosition!,
//                     child: const Icon(Icons.account_circle_sharp,color: Colors.lightBlueAccent,),
//                   ),
//                 ]),
//               ],
//             ));
//     });
//   }
//
//
//
// // Future<void> getLocationUpdates() async {
// //   bool _serviceEnabled;
// //   PermissionStatus _permissionStatus;
// //
// //   _serviceEnabled = await _locationController.serviceEnabled();
// //   if (_serviceEnabled) {
// //     _serviceEnabled = await _locationController.requestService();
// //   } else {
// //     return;
// //   }
// //   _permissionStatus = await _locationController.hasPermission();
// //   if (_permissionStatus == PermissionStatus.denied) {
// //     _permissionStatus = await _locationController.requestPermission();
// //     if (_permissionStatus == PermissionStatus.granted) {
// //       return;
// //     }
// //   }
// //   _locationController.onLocationChanged
// //       .listen((LocationData currentLocation) {
// //     if (currentLocation.latitude != null &&
// //         currentLocation.longitude != null) {
// //       setState(() {
// //         _currentPosition =
// //             LatLng(currentLocation.latitude!, currentLocation.longitude!);
// //         print(_currentPosition);
// //       });
// //     }
// //   });
// // }
// }

import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
    static const routeName = 'MapScreen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
