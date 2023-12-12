import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/model/reservation_model.dart';
import 'package:flutter/material.dart';
import '../../constants/K_Network.dart';

class GuestWidget extends StatelessWidget {
  GuestWidget({super.key,required this.guest});

  TicketUserData guest;
  @override
  Widget build(BuildContext context) {
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color:Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey,
                child: ClipOval(
                    child: Image.network(
                      '${guest.avatar}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,))),
            SizedBox(width: size.width*0.03,),
            Column(
              children: [
                Row(
                  children: [
                    _textWidget(
                      guest.firstName,
                      isDefault?Colors.black:Colors.white,
                      20,
                      true,),
                    _textWidget(
                      guest.lastName,
                      isDefault?Colors.black:Colors.white,
                      20,
                      true,),
                  ],
                ),
              ],
            ),
          ],
        ),
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
