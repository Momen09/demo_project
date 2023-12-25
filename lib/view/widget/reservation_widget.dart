import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:demo_project/view/widget/stay_widget.dart';
import 'package:demo_project/view/widget/user_ticket.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../constants/K_Network.dart';
import '../../model/reservation_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    final selectedStartDate =
    DateFormat("d-MM-yyyy").format(widget.reservation.startDate!);
    final selectedEndDate =
    DateFormat("d-MM-yyyy").format(widget.reservation.endDate!);
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    bool isDefault = AdaptiveTheme.of(context).isDefault;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: reservation.stays!.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          for (var i = 0; i < reservation.stays!.length;i++)
          {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: ExpansionTile(
                  maintainState: true,
                  trailing: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                            '${reservation.stays![index].rooms![i].guests![i].avatar}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ))),
                  iconColor: isDefault ? Colors.black : Colors.white,
                  collapsedIconColor: isDefault ? Colors.black : Colors.white,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: _textWidget(
                    reservation.stays![index].name!,
                    isDefault ? Colors.black : Colors.white,
                    24,
                    true,
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: reservation.stays![index].stayImages![index],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        _textWidget(
                          'Hotel check-in',
                          isDefault ? Colors.black : Colors.white,
                          20,
                          true,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        _textWidget(
                          reservation.stays![index].name,
                          isDefault ? Colors.black : Colors.grey,
                          15,
                          false,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: isDefault
                                  ? Colors.grey.shade200
                                  : Theme.of(context).scaffoldBackgroundColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    _firstGrid(
                                      from: selectedStartDate,
                                      to: selectedEndDate,
                                      stars:
                                      widget.reservation.stays![index].stars!,
                                      roomCount:
                                      '${widget.reservation.stays![index].rooms!.length.toString()} rooms',
                                      isDefault: isDefault
                                          ? Colors.black
                                          : Colors.white,
                                    ),
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
                                      height: size.height * 0.01,
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
                                      height: size.height * 0.01,
                                    ),
                                    UserTicketWidget(
                                        userTicket:
                                        reservation.userTickets![index]),
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),
                                    dotLine(size),
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),
                                    _textWidget(
                                      'Room reservation ${index + 1}',
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
                                    _guestWidget(reservation.stays![index].rooms!),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    _guestWidget(reservation.stays![index].rooms!),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    _textWidget(
                                      'Room type :',
                                      isDefault ? Colors.black : Colors.white,
                                      25,
                                      true,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    _textWidget(
                                      reservation
                                          .stays![index].rooms![i].roomTypeName!,
                                      Colors.grey.shade600,
                                      15,
                                      false,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.08,
                                    ),
                                    _secondGrid(
                                      roomNumber: reservation
                                          .stays![index].rooms![i].roomNumber!,
                                      sleeps: reservation
                                          .stays![index].rooms![i].roomCapacity
                                          .toString(),
                                      isDefault: isDefault
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.08,
                                    ),
                                    dotLine(size),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    _textWidget(
                                      'Gallery :',
                                      isDefault ? Colors.black : Colors.white,
                                      25,
                                      true,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    _galleryWidget(size,
                                        reservation.stays![index].stayImages),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    _textWidget(
                                      'Amenities :',
                                      isDefault ? Colors.black : Colors.white,
                                      25,
                                      true,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    _textWidget(
                                      reservation.stays![index].amenities,
                                      Colors.grey.shade600,
                                      15,
                                      false,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget _galleryWidget(Size size, images) {
    return SizedBox(
      height: size.height * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child:  CachedNetworkImage(
               imageUrl: images[index],
                width: size.width * 0.5,
                height: size.height * 0.3,
              ),

          );
        },
      ),
    );
  }

  GridView _firstGrid({
    required String from,
    required String to,
    required int stars,
    required String roomCount,
    required Color isDefault,
  }) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 32,
      ),
      children: [
        _buildDateDisplay('from', from),
        _buildDateDisplay('to', to),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textWidget('Stars', isDefault, 24, true),
            const Gap(5),
            Row(
              children: [
                for (var i = 0; i < stars; i++)
                  const Text(
                    '⭐',
                  ),
              ],
            ),
          ],
        ),
        _buildDateDisplay('roomCount', roomCount),
      ],
    );
  }

  GridView _secondGrid({
    required String roomNumber,
    required String sleeps,
    required Color isDefault,
  }) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 32,
      ),
      children: [
        _buildDateDisplay('Room Number', roomNumber),
        _buildDateDisplay('Sleeps', sleeps),
      ],
    );
  }

  Widget _buildDateDisplay(String title, String subtitle) {
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(subtitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                )),
          ],
        ),
      ],
    );
  }

  Widget _textWidget(
      var text,
      Color color,
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

  Widget _guestWidget(List<Room> rooms) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < rooms.length; i++)
            for (var j = 0; j < rooms[i].guests!.length; j++)
              ListTile(
                title: _textWidget(
                    '${rooms[i].guests![j].firstName!} ${rooms[i].guests![j].lastName!}',
                    Colors.grey,
                    20,
                    false),
                leading: CircleAvatar(
                    child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: '${rooms[i].guests![i].avatar}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ))),
              )
        ],
      ),
    );
  }
}
