import 'package:demo_project/model/reservation_model.dart';

class ApiUtility {
  static void openGoogleMaps(Stay stay) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=${stay.lat},${stay.lat}';
    }
  }

