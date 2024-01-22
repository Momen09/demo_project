import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class CurrentPosViewModel extends ChangeNotifier {
  final Location _locationController = Location();
  LatLng? _currentPosition;

  LatLng get currentPosition => _currentPosition!;

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionStatus = await _locationController.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _locationController.requestPermission();
      if (permissionStatus == PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        _currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        print(_currentPosition);
        notifyListeners();
      }
    });
  }
}
