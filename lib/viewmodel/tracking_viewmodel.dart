import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../constants/K_Network.dart';
import '../constants/enum.dart';

class TrackingViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.initial;

  ViewState get viewState => _viewState;
  LocationData? _currentLocation;
  final Completer<GoogleMapController> _controller = Completer();

  Completer<GoogleMapController> get controller => _controller;

  LocationData? get currentLocation => _currentLocation;
  final List<LatLng> _locationHistory = [];


  List<LatLng> get locationHistory => _locationHistory;

  Future<void> getCurrentLocation() async {
    _viewState = ViewState.loading;
    Location location = Location();
    location.getLocation().then((location) {
      _viewState = ViewState.loaded;
      notifyListeners();
      _currentLocation = location;
    });
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((loc) async {
      _currentLocation = loc;
      _locationHistory.add(LatLng(loc.latitude!, loc.longitude!));
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 13.5, target: LatLng(loc.latitude!, loc.longitude!)))).then((v) {


      }).catchError((error){
        print(error);
      });
      notifyListeners();

      return;
    });
  }

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
  }

  LatLng source = const LatLng(30.1152, 31.3412);
  LatLng destination = const LatLng(30.099170, 31.384760);

  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      KNetwork.google_api_key,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.bicycling,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
    notifyListeners();
    notifyListeners();

  }
  List<LatLng> polylinePointss = [];

  void addPointToPolyline(LatLng point) {
    polylinePointss.add(point);
    notifyListeners();
  }
}
