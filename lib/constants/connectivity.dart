// // import 'package:flutter/material.dart';
// //
// // class ConnectivityWidget extends StatelessWidget {
// //   const ConnectivityWidget({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SnackBar(content: content);
// //   }
// // }
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class NetworkController extends ChangeNotifier {
//   final Connectivity _connectivity = Connectivity();
//
//   void _updateConnectionStatus(ConnectivityResult connectivityResult) {
//     if (connectivityResult == ConnectivityResult.none) {
//        const SnackBar(
//         content: Text('PLEASE CONNECT TO INTERNET'),
//         backgroundColor: Colors.red,
//         duration: Duration(days: 1),
//         shape: Border(top: BorderSide(width: 1)),
//       );
//     }
//   }
//   @override
//   void notifyListeners() {
//     _connectivity.onConnectivityChanged.listen((event) {_updateConnectionStatus;});
//     super.notifyListeners();
//   }
// }
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'enum.dart';




class NetworkService extends ChangeNotifier {
  StreamController<NetworkStatus> _controller = StreamController();
  Stream<NetworkStatus> get networkStatusStream => _controller.stream;


  NetworkService() {
    Connectivity().onConnectivityChanged.listen((event) {
      _controller.add(_networkStatus(event));
      notifyListeners();
    });
  }

  NetworkStatus _networkStatus(ConnectivityResult connectivityResult) {
    return connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
  notifyListeners();
}
