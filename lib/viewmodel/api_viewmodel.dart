import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_project/constants/Network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../model/reservation_model.dart';
import '../constants/enum.dart';

class ReservationViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.initial;

  ViewState get viewState => _viewState;

  List<Reservation> get reservations => _reservations;

  List<Reservation> _reservations = [];


  Future<void> reservationData(response) async {
    final data =response;
    for (var reservation in data['reservations']) {
      _reservations.add(Reservation.fromJson(reservation));

    }
    _viewState = ViewState.loaded;
    return;
  }

  Future<void> fetchData(apiUrl) async {
    _viewState = ViewState.loading;
    try {
      var connectivityResult = Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        dynamic cachedData = NetworkRequests.DioNetwork();
        if (cachedData != null) {
          await reservationData(cachedData);
        } else {
          _viewState = ViewState.error;
        }
      } else {
        await fetchAndCacheData();
      }
    } catch (e) {
      _viewState = ViewState.error;
      log("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchAndCacheData() async {
    try {
      final response = await NetworkRequests.DioNetwork();
      final jsonString = jsonEncode(response.data);
      log("API Response: $jsonString");
      await reservationData(response.data);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          log('Authentication error: Unauthorized');
          // Handle unauthorized error, e.g., redirect to login screen
        } else {
          log('DioError: $e');
        }
      } else {
        log('Unexpected error: $e');
      }
    }
  }

  set viewState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  set reservations(List<Reservation> reservations) {
    _reservations = reservations;
    notifyListeners();
  }
}
