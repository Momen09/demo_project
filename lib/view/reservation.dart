import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:custom_clippers/Clippers/ticket_pass_clipper.dart';
import 'package:demo_project/constants/K_Network.dart';
import 'package:demo_project/constants/list.dart';
import 'package:demo_project/view/loading_screen.dart';
import 'package:demo_project/view/widget/reservation_widget.dart';
import 'package:flutter/cupertino.dart';
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
    Future.delayed(const Duration(seconds: 1))
        .then((value) => context.read<ApiViewModel>().getUserEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).isDefault;
    final colorTheme = isDark ? Colors.black : Colors.white;
    SizeScreen sizeScreen = SizeScreen(context);
    Size size = sizeScreen.getScreenSize;
    Reservation reservation;
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
      body: Consumer<ApiViewModel>(builder: (context, provider, child) {
        if (provider.viewState == ViewState.loading) {
          return const Center(
            child: LoadingScreen(),
          );
        }
        if (provider.viewState == ViewState.loaded) {
          return _ReservationWidgetScreen(provider.reservations);
          // ListView(
          //   children: [
          //     Image.network(
          //       provider.reservations.first.stays!.first.stayImages!.first,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Container(
          //         color: isDark
          //             ? Colors.grey.shade200
          //             : Theme.of(context).scaffoldBackgroundColor,
          //         child: Padding(
          //           padding: const EdgeInsets.all(22.0),
          //           child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: size.height * 0.03,
          //                 ),
          //                 _textWidget(
          //                   'Hotel Check-in',
          //                   isDark ? Colors.black : Colors.white,
          //                   20,
          //                   true,
          //                 ),
          //                 SizedBox(
          //                   height: size.height * 0.02,
          //                 ),
          //                 _textWidget(
          //                   provider.reservations.first.id.toString(),
          //                   isDark ? Colors.black : Colors.grey,
          //                   15,
          //                   false,
          //                 ),
          //                 SizedBox(
          //                   height: size.height * 0.03,
          //                 ),
          //                 firstGrid(isDark),
          //                 _textWidget(
          //                   'Location:',
          //                   colorTheme,
          //                   20,
          //                   true,
          //                 ),
          //                 SizedBox(
          //                   height: size.height * 0.03,
          //                 ),
          //                 _addressContainer(provider, size),
          //                 SizedBox(
          //                   height: size.height * 0.06,
          //                 ),
          //                 _textWidget(
          //                   'Tickets:',
          //                   colorTheme,
          //                   20,
          //                   true,
          //                 ),
          //                 SizedBox(
          //                   height: size.height * 0.02,
          //                 ),
          //                 ClipPath(
          //                   clipper: TicketPassClipper(
          //                     position: 8,
          //                   ),
          //                   child: ticket1(size, provider),
          //                 ),
          //                 dotLine(size),
          //                 ClipPath(
          //                     clipper: TicketPassClipper(
          //                       position: 8,
          //                     ),
          //                     child: ticket2(size)),
          //                 SizedBox(
          //                   height: size.height * 0.06,
          //                 ),
          //                 dotLine(size),
          //                 SizedBox(
          //                   height: size.height * 0.06,
          //                 ),
          //                 _textWidget(
          //                   'Room Reservation :',
          //                   colorTheme,
          //                   20,
          //                   true,
          //                 ),
          //                 SizedBox(
          //                   height: size.height * 0.06,
          //                 ),
          //                 _textWidget(
          //                   'Guest(s) :',
          //                   colorTheme,
          //                   20,
          //                   true,
          //                 ),
          //                 SizedBox(
          //                   height: size.height * 0.03,
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Row(
          //                       children: [
          //                         circleImage(provider),
          //                         SizedBox(
          //                           width: size.height * 0.03,
          //                         ),
          //                         _textWidget(
          //                           '${provider.reservations.first.stays!.first.rooms!.first.guests!.first.firstName} '
          //                           '${provider.reservations.first.stays!.first.rooms!.first.guests!.first.lastName}',
          //                           colorTheme,
          //                           20,
          //                           true,
          //                         ),
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: size.height * 0.06,
          //                     ),
          //                     _textWidget(
          //                       'Room type :',
          //                       colorTheme,
          //                       20,
          //                       true,
          //                     ),
          //                     SizedBox(
          //                       height: size.height * 0.01,
          //                     ),
          //                     _textWidget(
          //                       provider.reservations.first.stays!.first.rooms!
          //                           .first.roomTypeName,
          //                       Colors.grey.shade600,
          //                       15,
          //                       false,
          //                     ),
          //                     SizedBox(
          //                       height: size.height * 0.08,
          //                     ),
          //                     secGrid(isDark),
          //                     dotLine(size),
          //                     SizedBox(
          //                       height: size.height * 0.08,
          //                     ),
          //                     _textWidget(
          //                       'Gallery :',
          //                       colorTheme,
          //                       20,
          //                       true,
          //                     ),
          //                     SizedBox(
          //                       height: size.height * 0.02,
          //                     ),
          //                     _galleryWidget(
          //                         size,
          //                         provider.reservations!.first.stays!.first
          //                             .stayImages!),
          //                     SizedBox(
          //                       height: size.height * 0.08,
          //                     ),
          //                     _textWidget(
          //                       'Amenities :',
          //                       colorTheme,
          //                       20,
          //                       true,
          //                     ),
          //                     SizedBox(
          //                       height: size.height * 0.02,
          //                     ),
          //                     _textWidget(
          //                       provider
          //                           .reservations.first.stays!.first.amenities,
          //                       Colors.grey.shade600,
          //                       15,
          //                       true,
          //                     ),
          //                     SizedBox(
          //                       height: size.height * 0.02,
          //                     ),
          //                   ],
          //                 ),
          //               ]),
          //         ),
          //       ),
          //     ),
          //   ],
          // );
        } else {
          return Container();
        }
      }),
    );
  }

  // Widget _galleryWidget(Size size, List<String> images) {
  //   return SizedBox(
  //     height: size.height * 0.3,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       shrinkWrap: true,
  //       itemCount: images.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           margin: const EdgeInsets.only(right: 10),
  //           child: Image.network(
  //             images[index],
  //             width: size.width * 0.5,
  //             height: size.height * 0.3,
  //             fit: BoxFit.cover,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  // Widget _addressContainer(ApiViewModel provider, Size size) {
  //   double latitude =
  //       double.parse(provider.reservations!.first.stays!.first.lat!);
  //   double longitude =
  //       double.parse(provider.reservations!.first.stays!.first.lng!);
  //   bool isDark = AdaptiveTheme.of(context).isDefault;
  //   final colorTheme = isDark ? Colors.black : Colors.white;
  //
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: isDark ? Colors.grey.shade400 : Colors.grey,
  //       borderRadius: BorderRadius.circular(0),
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Flexible(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: _textWidget(
  //                   provider.reservations.first.stays!.first.name,
  //                   colorTheme,
  //                   20,
  //                   true,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: size.height * 0.01,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 8.0),
  //                 child: _textWidget(
  //                     'Address: ${provider.reservations.first.stays!.first.address}',
  //                     isDark ? Colors.black : Colors.white,
  //                     15,
  //                     false),
  //               ),
  //             ],
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             provider.openGoogleMapsForFirstStay(context,isDark);
  //           },
  //           child: Image.asset(
  //             width: size.width * 0.40,
  //             height: size.height * 0.22,
  //             KNetwork.locationPhoto,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // GridView firstGrid(bool isDark) {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 0.0,
  //       mainAxisSpacing: 0.0,
  //     ),
  //     itemCount: 4,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         color: isDark
  //             ? Colors.grey.shade200
  //             : Theme.of(context).scaffoldBackgroundColor,
  //         child: ListTile(
  //           title: _textWidget(
  //             hotelList[index],
  //             isDark ? Colors.black : Colors.white,
  //             20,
  //             true,
  //           ),
  //           subtitle: _textWidget(
  //             FirstList(context).getApiList()[index],
  //             isDark ? Colors.black : Colors.grey,
  //             15,
  //             false,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // GridView secGrid(bool isDark) {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 0.0,
  //       mainAxisSpacing: 0.0,
  //     ),
  //     itemCount: 2,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         color: isDark
  //             ? Colors.grey.shade200
  //             : Theme.of(context).scaffoldBackgroundColor,
  //         child: ListTile(
  //           title: _textWidget(
  //             RoomList[index],
  //             isDark ? Colors.black : Colors.white,
  //             20,
  //             true,
  //           ),
  //           subtitle: _textWidget(
  //             SecList(context).getSecList()[index],
  //             isDark ? Colors.black : Colors.grey,
  //             15,
  //             false,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Container ticket1(Size size, ApiViewModel provider) {
  //   bool isDark = AdaptiveTheme.of(context).isDefault;
  //   return Container(
  //     height: size.height * 0.1,
  //     width: size.width,
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //     decoration: BoxDecoration(
  //       color: isDark ? Colors.grey.shade400 : Colors.grey,
  //       borderRadius: BorderRadius.circular(0),
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         circleImage(provider),
  //         SizedBox(
  //           width: size.width * 0.03,
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             _textWidget(
  //               '${provider.reservations.first.stays!.first.rooms!.first.guests!.first.firstName} '
  //               '${provider.reservations.first.stays!.first.rooms!.first.guests!.first.lastName}',
  //               isDark ? Colors.black : Colors.white,
  //               20,
  //               true,
  //             ),
  //             _textWidget(
  //               '#1903420758',
  //               Colors.grey.shade600,
  //               15,
  //               false,
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Container ticket2(Size size) {
  //   bool isDark = AdaptiveTheme.of(context).isDefault;
  //   return Container(
  //     height: size.height * 0.1,
  //     width: size.width,
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //     decoration: BoxDecoration(
  //       color: isDark ? Colors.grey.shade400 : Colors.grey,
  //       borderRadius: BorderRadius.circular(0),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _textWidget(
  //             'Ticket Type :', isDark ? Colors.black : Colors.white, 18, true),
  //         SizedBox(
  //           height: size.height * 0.01,
  //         ),
  //         _textWidget('Seat :', isDark ? Colors.black : Colors.white, 18, true),
  //       ],
  //     ),
  //   );
  // }
  //
  // CircleAvatar circleImage(ApiViewModel provider) {
  //   return CircleAvatar(
  //     backgroundColor: Colors.grey, // Set the background color
  //     child: ClipOval(
  //       child: Image.network(
  //         '${provider.reservations.first.stays!.first.rooms!.first.guests!.first.avatar}',
  //         width: 50, // Set the width as per your requirement
  //         height: 50, // Set the height as per your requirement
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }
  //
  // FDottedLine dotLine(Size size) {
  //   return FDottedLine(
  //     color: Colors.grey,
  //     width: size.width,
  //     strokeWidth: 2.0,
  //     dottedLength: 10.0,
  //     space: 2.0,
  //   );
  // }
  //
  // Widget _textWidget(
  //   var text,
  //   color,
  //   double textSize,
  //   bool isTitle,
  // ) {
  //   return Text(
  //     text,
  //     style: TextStyle(
  //       color: color,
  //       fontSize: textSize,
  //       fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
  //     ),
  //   );
  // }
  Widget _ReservationWidgetScreen(List<Reservation> reservations) {
    return ListView.separated(
      separatorBuilder: (context, index) =>  Container(
        color: Colors.red,
        height: 10,
      ),
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        return ReservationWidget(
          reservation: reservations[index],
        );
      },
    );
  }
}
