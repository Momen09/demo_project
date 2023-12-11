import 'dart:developer';

import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/model/reservation_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'map_viewmodel.dart';

enum ViewState { initial, loading, loaded, error }

class ApiViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.initial;

  ViewState get viewState => _viewState;

  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

  final Dio dio = Dio();

  Future<void> getUserEvents() async {
    const url = ApiUrl.apiUrl;

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
      log('API Response: $response');
      if (response.statusCode == 200) {
        final data = response.data;
        for (var reservation in data['reservations']) {
          _reservations.add(Reservation.fromJson(reservation));
        }
        _viewState = ViewState.loaded;
      } else {
        _viewState = ViewState.error;
        throw Exception(
            'Failed to fetch user events. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    } finally {
      notifyListeners();
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


 Future <void> openGoogleMapsForFirstStay(BuildContext context) async {
  double latitude =await double.parse(reservations!.first.stays!.first.lat!);
  double longitude =await double.parse(reservations!.first.stays!.first.lng!);

  ApiUtility.openGoogleMaps(latitude, longitude);
  notifyListeners();
  }

}
