import 'package:flutter/material.dart';
import '../model/api_model.dart';

class UserEventsViewModel with ChangeNotifier {
  final ApiModel _apiModel = ApiModel();
  late Map<String, dynamic> _userEvents = {}; // Initialize with an empty map

  Map<String, dynamic> get userEvents => _userEvents;

  Future<void> fetchUserEvents(String token) async {
    try {
      _userEvents = await _apiModel.getUserEvents();
      notifyListeners();
    } catch (e) {
      print('Error fetching user events: $e');
    }
  }
}
