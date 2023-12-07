import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/constants/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/reservation_model.dart';
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
    // TODO: implement initState
    Future.delayed(Duration(seconds: 0))
        .then((value) => context.read<ApiViewModel>().getUserEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool _isDark = AdaptiveTheme.of(context).isDefault;
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ApiViewModel>(builder: (context, provider, child) {
            if (provider.viewState == ViewState.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (provider.viewState == ViewState.loaded) {
              return ListView(
                children: [
                  _staysWidget(provider.reservations.first.stays!),
                  Image.asset(
                    'assets/images/img.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  _textWidget(
                    'Hotel Check-in',
                    _isDark ? Colors.black : Colors.white,
                    20,
                    true,
                  ),
                  _textWidget(
                    provider.reservations.first.stays!.first.name,
                    _isDark ? Colors.black : Colors.grey,
                    15,
                    false,
                  ),
                  // SizedBox(
                  //   height: sizeScreen.getScreenSize.height * 0.2,
                  // ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 50.0,
                        mainAxisSpacing: 0.2,
                      ),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ListTile(
                            title: _textWidget(
                              hotelList[index],
                              _isDark ? Colors.black : Colors.white,
                              20,
                              true,
                            ),
                            subtitle: _textWidget(
                              '',
                              _isDark ? Colors.black : Colors.grey,
                              15,
                              false,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  _textWidget(
                    'Location:',
                    Colors.white,
                    20,
                    true,
                  ),
                  
                  InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textWidget(
                              '', // apiViewModel.reservations.first.stays
                              //     ?.map((e) => e.name),
                              Colors.white,
                              20,
                              true,
                            ),
                            _textWidget(
                              '',
                              // apiViewModel.reservations.first.stays
                              //     ?.forEach((e) => e.address.toString()),
                              Colors.grey,
                              15,
                              false,
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/img.png',
                          // apiViewModel.reservations.first.stays
                          // ?.map((e) => e.stayImages?.first) as String),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
  
  Widget _staysWidget(List<Stay> stays){
    return ListView(
      shrinkWrap: true,
    );
  }

  Widget _textWidget(var text, color, double textSize, bool isTitle) {
    return Text(
      text,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: textSize,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
    );
  }
}
