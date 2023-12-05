// model.dart
import 'dart:developer';

import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/model/user_event_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum ViewState { initial, loading, loaded, error }

class ApiModel extends ChangeNotifier {
  ViewState _viewState = ViewState.initial;



  ViewState get viewState => _viewState;

  UserEvents ? userEvents ;



  final Dio dio = Dio();
  Future<Map<String, dynamic>> getUserEvents() async {
    const url =
        'https://qa-testing-backend-293b1363694d.herokuapp.com//api/v3/mobile-guests/user-events';

    try {
      _viewState = ViewState.loading;
      notifyListeners();
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${KNetwork.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        /// this is where i should handle the retrieved data from the the api request

        userEvents = UserEvents.fromJson(response.data['user_events']);
        log(userEvents!.userTickets.length.toString());
        return response.data;
      } else {
        throw Exception(
            'Failed to fetch user events. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  set viewState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }
}
