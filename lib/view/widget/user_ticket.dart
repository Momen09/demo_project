import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/model/reservation_model.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import '../../constants/K_Network.dart';

class UserTicketWidget extends StatelessWidget {
  UserTicketWidget({super.key,required this.userTicket});
  UserTicket userTicket;
  @override
  Widget build(BuildContext context) {
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height*0.1,
          decoration: BoxDecoration(
            color: isDefault ?Colors.grey.shade400:Colors.grey,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: ClipOval(
                      child: Image.network(
                        '${userTicket.ticketUserData!.avatar}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,))),
              SizedBox(width: size.width*0.02,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                    _textWidget(
                    userTicket.ticketUserData!.firstName,
                    isDefault?Colors.black:Colors.white,
                    20,
                    true,),
                      _textWidget(
                        userTicket.ticketUserData!.lastName,
                        isDefault?Colors.black:Colors.white,
                        20,
                        true,),
                    ],
                  ),
                  // _textWidget(userTicket.ticketUserData., color, textSize, isTitle)
                ],
              ),
            ],
          ),
        ),
        dotLine(size),
        Container(
          width: size.width,
          height: size.height*0.1,
          decoration: BoxDecoration(
            color: isDefault ?Colors.grey.shade400:Colors.grey,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textWidget(
                    'Ticket type : ${userTicket.ticketTypeName}',
                    isDefault?Colors.black:Colors.white,
                    20,
                    true,),
                  _textWidget(
                    'Seat: ${userTicket.ticketSystemId}',
                    isDefault?Colors.black:Colors.white,
                    20,
                    true,),
                ],
              ),
            ],
          ),
        ),
      ],
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
FDottedLine dotLine(Size size) {
  return FDottedLine(
    color: Colors.grey,
    width: size.width,
    strokeWidth: 2.0,
    dottedLength: 10.0,
    space: 2.0,
  );
}
