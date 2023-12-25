import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/K_Network.dart';
import '../../model/reservation_model.dart';
import '../../viewmodel/map_viewmodel.dart';

class StayWidget extends StatelessWidget {
  StayWidget({super.key, required this.stay});
  Stay stay;



  @override
  Widget build(BuildContext context) {
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    return Container(
      decoration: BoxDecoration(
        color: isDefault ?Colors.grey.shade300:Colors.grey,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _textWidget(
                    stay.name,
                    isDefault?Colors.black:Colors.white,
                    20,
                    true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _textWidget(
                      'Address: ${stay.address}',
                      isDefault ? Colors.black : Colors.white,
                      15,
                      false),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              ApiUtility.openGoogleMaps(stay);
            },
            child: Image.asset(
              width: size.width * 0.40,
              height: size.height * 0.22,
              KNetwork.locationPhoto,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _textWidget(
    var text,
    color,
    double textSize,
    bool isTitle,
    ) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: textSize,
      fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
