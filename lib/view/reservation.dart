import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/view/loading_screen.dart';
import 'package:demo_project/view/widget/reservation_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import '../model/reservation_model.dart';
import '../constants/enum.dart';
import '../viewmodel/api_viewmodel.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  static const routeName = 'ReservationScreen';

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) =>
        context.read<ReservationViewModel>().fetchData(ApiUrl.apiUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: Colors.grey.withOpacity(0.8),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        )),
        title: Center(
          child: Container(
            height: size.height * 0.01,
            width: size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(''),
            ),
          ),
        ),
      ),
      body: Consumer<ReservationViewModel>(builder: (context, provider, child) {
        if (provider.viewState == ViewState.initial ||
            provider.viewState == ViewState.loading) {
          return const LoadingScreen();
        }
        if (provider.viewState == ViewState.loaded) {
          return _ReservationWidgetScreen(provider.reservations);
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _ReservationWidgetScreen(List<Reservation> reservations) {
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    return ListView(
      children: [
        Container(
            height: size.height * 0.34,
            width: size.width,
            child: InstaImageViewer(
                child: PhotoView(
                    imageProvider: const AssetImage('${KNetwork.photo}2.jpg')))),
        const Gap(20),
        ListTile(
          title: Text(
            'Hotel Check-in',
            style: TextStyle(
                color: isDefault ? Colors.black : Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Multiple Reservations',
            style: TextStyle(
                color: isDefault ? Colors.black : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
        ),
        const Gap(10),
        ReservationWidget(
          reservation: reservations.first,
        ),
      ],
    );
  }
}
