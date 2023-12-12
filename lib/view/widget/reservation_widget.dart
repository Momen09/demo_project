import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/constants/list.dart';
import 'package:demo_project/view/widget/guest_widget.dart';
import 'package:demo_project/view/widget/stay_widget.dart';
import 'package:demo_project/view/widget/user_ticket.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/K_Network.dart';
import '../../model/reservation_model.dart';

class ReservationWidget extends StatefulWidget {
  const ReservationWidget({
    super.key,
    required this.reservation,
  });

  final Reservation reservation;

  @override
  State<ReservationWidget> createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {


  Reservation get reservation => widget.reservation;

  @override
  Widget build(BuildContext context) {
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.reservation.stays!.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: isDefault
                  ? Colors.grey.shade600
                  : Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textWidget(
                    widget.reservation.stays![index].name,
                    Colors.grey,
                    15,
                    false,
                  ),
                  _firstGrid(isDefault),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  _textWidget(
                    'Location:',
                    isDefault ? Colors.black : Colors.white,
                    25,
                    true,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  StayWidget(stay: reservation.stays![index]),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  _textWidget(
                    'Ticket:',
                    isDefault ? Colors.black : Colors.white,
                    25,
                    true,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  // ...widget.stays[index].rooms!.map((e) => RoomWidget(room: e)),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ...widget.reservation.userTickets!.map((e) => UserTicketWidget(userTicket: e)),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  dotLine(size),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  _textWidget(
                    'Room reservation 01',
                    isDefault ? Colors.black : Colors.white,
                    25,
                    true,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  _textWidget(
                    'Guests:',
                    isDefault ? Colors.black : Colors.white,
                    25,
                    true,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ),
          );
        });
  }

  GridView _firstGrid(bool isDefault) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 32,
      ),
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: isDefault
              ? Colors.grey.shade200
              : Theme.of(context).scaffoldBackgroundColor,
          child: ListTile(
            title: _textWidget(
              hotelList[index],
              isDefault ? Colors.black : Colors.white,
              20,
              true,
            ),
            subtitle: _textWidget(
              DateFormat("d-MM-yyyy").format(widget.reservation.startDate!),
              isDefault ? Colors.black : Colors.grey,
              15,
              false,
            ),
          ),
        );
      },
    );
  }

  Widget _ticket1(Size size, isDefault, index) {
    return Container(
      height: size.height * 0.1,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isDefault ? Colors.grey.shade400 : Colors.grey,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // circleImage(provider),
          SizedBox(
            width: size.width * 0.03,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textWidget(
                '${reservation.stays![index].rooms![index].guests![index].firstName} '
                '${reservation.stays![index].rooms![index].guests![index].firstName}',
                isDefault ? Colors.black : Colors.white,
                20,
                true,
              ),
              _textWidget(
                '#1903420758',
                Colors.grey.shade600,
                15,
                false,
              ),
            ],
          )
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
    color: Colors.grey,
    width: size.width,
    strokeWidth: 2.0,
    dottedLength: 10.0,
    space: 2.0,
  );
}
