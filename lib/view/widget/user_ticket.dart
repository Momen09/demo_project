import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:demo_project/model/reservation_model.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../constants/K_Network.dart';

class UserTicketWidget extends StatelessWidget {
  UserTicketWidget({super.key, required this.userTicket});

  UserTicket? userTicket;

  @override
  Widget build(BuildContext context) {
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    return Column(
      children: [
        CouponCard(
          height: size.height*0.2,
          curvePosition: size.height * 0.09,
          decoration: BoxDecoration(
            color: isDefault ? Colors.grey.shade300 : Colors.grey,
            borderRadius: BorderRadius.circular(0),
          ),
          firstChild: Column(
            children: [
              _guestWidget(isDefault),
            ],
          ), secondChild: _ticketDetailsWidget(isDefault,context),
        ),

      ],
    );
  }

  Widget _guestWidget(isDefault) {
    return ListTile(
      title: _textWidget(
        '${userTicket!.ticketUserData!.firstName} ${userTicket!.ticketUserData!.lastName}',
        isDefault?Colors.black:Colors.white,
        20,
        true,
      ),
      subtitle:_textWidget('${userTicket!.ticketSystemId}', Colors.grey.shade600, 15, false),
      leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: ClipOval(
              child: CachedNetworkImage(imageUrl:
              '${userTicket!.ticketUserData!.avatar}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ))),
    );
  }
  Widget _ticketDetailsWidget(isDefault,context){
    return Container(
      height: 30,
      width: double.maxFinite,
      decoration:  BoxDecoration(
        border: Border(
          top: BorderSide(color:Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _textWidget('Ticket type : ',isDefault ?Colors.black:Colors.white, 18, true),
              _textWidget(userTicket!.ticketTypeName,isDefault? Colors.black:Colors.grey.shade600, 18, false),
            ],
          ),
          const Gap(10),
          Row(
            children: [
              _textWidget('Seat : ',isDefault ?Colors.black:Colors.white, 18, true),
              _textWidget('Gate ${userTicket!.gate!} Seat ${userTicket!.seat!}',isDefault? Colors.black:Colors.grey.shade600, 18, false),
            ],
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

FDottedLine dotLine(Size size) {
  return FDottedLine(
    color: Colors.black,
    width: size.width,
    strokeWidth: 2.0,
    dottedLength: 10.0,
    space: 2.0,
  );
}
