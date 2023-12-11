import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../viewmodel/api_viewmodel.dart';

List hotelList= [
  'FROM',
  'TILL',
  'STARS',
  'Room counts',
];

List RoomList =[
  'Room number',
  'Sleeps',
];

class FirstList {
  late BuildContext context;

  FirstList(this.context);

  List<String> getApiList() {
    final apiViewModel =Provider.of<ApiViewModel>(context);
    final selectedStartDate =  DateFormat("d-MM-yyyy").format(apiViewModel.reservations.first.startDate!);
    final selectedEndDate =  DateFormat("d-MM-yyyy").format(apiViewModel.reservations.first.endDate!);


    int starCount = apiViewModel.reservations!.first.stays!.first.stars ?? 0;
    String star = "";
    for (int i = 0; i < starCount; i++) {
      star= "$star⭐" ;
    }
    return [
      selectedStartDate,
      selectedEndDate,
      star,
      '${apiViewModel.reservations.first.stays!.first.rooms!.first.roomNumber}',
    ];
  }
}

class SecList {
  late BuildContext context;

  SecList(this.context);

  List<String> getSecList() {
    return [
      '${Provider.of<ApiViewModel>(context).reservations.first.stays!.first.rooms!.first.roomNumber}',
      '${Provider.of<ApiViewModel>(context).reservations.first.stays!.first.rooms!.first.roomCapacity}',
    ];
  }
}

 List galleryPhoto= [
   'assets/images/1.jpg',
   'assets/images/2.jpg',
   'assets/images/3.jpg',
 ];
class GalleryPhoto {
  late BuildContext context;

  GalleryPhoto (this.context);
  List<Image> getPhotoList() {
    return [
      Image.network(Provider.of<ApiViewModel>(context).reservations.first.stays!.first.stayImages!.first),
      Image.network(Provider.of<ApiViewModel>(context).reservations.first.stays!.first.stayImages!.last),
      
    ];
  }
}




