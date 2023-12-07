import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/constants/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/api_viewmodel.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  static const routeName = 'ReservationScreen';

  @override
  Widget build(BuildContext context) {
    final bool _isDark = AdaptiveTheme.of(context).isDefault;
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
        return SafeArea(
          child: Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ApiViewModel>(
            builder: (context,T,child) {
              final apiViewModel = Provider.of<ApiViewModel>(context);
              return ListView(
                children: [
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
                  apiViewModel.reservations.first.startDate.toString()
                    ,
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        )],
                    ),
                  ),
                ],
              );
            }
          ),
      ),
    ),
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
