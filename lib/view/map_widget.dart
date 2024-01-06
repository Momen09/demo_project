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

import 'dart:async';
import 'package:demo_project/constants/enum.dart';
import 'package:demo_project/view/loading_screen.dart';
import 'package:demo_project/viewmodel/tracking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  static const routeName = 'MapScreen';

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late TrackingViewModel _trackingViewModel;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) {
      _trackingViewModel =
          Provider.of<TrackingViewModel>(context, listen: false);
      _trackingViewModel.getCurrentLocation();
       _trackingViewModel.polylines;
    });
    super.initState();
  }

  LatLng source = const LatLng(30.1152, 31.3412);
  LatLng destination = const LatLng(30.099170, 31.384760);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingViewModel>(
        builder: (context, trackingViewModel, child) {
      LocationData? currentLocation = trackingViewModel.currentLocation;
      List<LatLng> locationHistory = trackingViewModel.locationHistory;
      if (trackingViewModel.viewState == ViewState.initial ||
          trackingViewModel.viewState == ViewState.loading) {
        return const LoadingScreen();
      }else{
        return Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: _historyList(locationHistory),
          ),
          body: _mapView(trackingViewModel, currentLocation),
        );
      }
    });
  }




  GoogleMap _mapView(TrackingViewModel trackingViewModel, LocationData? currentLocation) {
    return GoogleMap(
          // onTap: (LatLng latlng) {
          //   setState(() {
          //     Marker(
          //         markerId: MarkerId('${latlng.latitude}'),
          //         position: LatLng(latlng.latitude, latlng.longitude));
          //   });
          // },
          polylines: Set<Polyline>.of(trackingViewModel.polylines.values),
          markers: {
            Marker(
                markerId: const MarkerId('current'),
                position: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!)),
            Marker(markerId: const MarkerId('source'), position: source),
            Marker(
                markerId: const MarkerId('destination'),
                position: destination),
          },
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 13.5,
          ),
          onMapCreated: (controllerr) {
            trackingViewModel.controller.complete(controllerr);
            // _getPolyline();
          },
        );
  }

  Widget _historyList(List<LatLng> locationHistory) {
    return ListView.builder(
            itemCount: locationHistory.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              LatLng location = locationHistory[index];
              return ListTile(
                title: Text('Location $index'),
                subtitle: Text(
                    'Latitude: ${location.latitude}, Longitude: ${location.longitude}'),
              );
            },
          );
  }
}
