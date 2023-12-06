
import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/model/reservation_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum ViewState { initial, loading, loaded, error }

class ApiModel extends ChangeNotifier {
  ViewState _viewState = ViewState.initial;

  ViewState get viewState => _viewState;

  List<Reservation> _reservations = [];

  List<Reservation> get reservations => _reservations;

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
        final data = response.data;
        for (var reservation in data['reservations']) {
          _reservations.add(Reservation.fromJson(reservation));

        }

        return response.data;
      } else {
        throw Exception(
            'Failed to fetch user events. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
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
