import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/enum.dart';

class ConnectivityWidget extends StatefulWidget {
  const ConnectivityWidget({super.key});

  @override
  State<ConnectivityWidget> createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    return Scaffold(
      body:networkStatus == NetworkStatus.online
          ? buildOnlineContent()
          : buildOfflineContent(),
    );
  }

  Widget buildOnlineContent() {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(' connect to the internet'),
          duration: Duration(seconds: 3),
        ),
      );
    });
    return Container();
  }

  Widget buildOfflineContent() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please connect to the internet'),
          duration: Duration(seconds: 3),
        ),
      );
    });
    return Container();
  }
}
