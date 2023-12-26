import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class CurrentPosViewModel extends ChangeNotifier{
  final Location  _locationController = Location();
   LatLng? _currentPosition;
  final MapController mapController = MapController();

  LatLng get currentPosition => _currentPosition!;

  Future<void> _cameraToPosition(LatLng pos)async{
    final MapController controller = mapController;
    MapOptions _newCameraPosition = MapOptions(zoom: 13,initialCenter: pos);
  }

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

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
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
