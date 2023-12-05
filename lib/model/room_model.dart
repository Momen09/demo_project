import 'package:demo_project/model/ticket_user_data.dart';
import 'package:flutter/cupertino.dart';

class Room extends ChangeNotifier{
  int roomNumber;
  int roomCapacity;
  String roomTypeName;
  String stayName;
  List<TicketUserData> guests;

  Room({
    required this.roomNumber,
    required this.roomCapacity,
    required this.roomTypeName,
    required this.stayName,
    required this.guests,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    roomNumber: json["room_number"],
    roomCapacity: json["room_capacity"],
    roomTypeName: json["room_type_name"],
    stayName: json["stay_name"],
    guests: List<TicketUserData>.from(json["guests"].map((x) => TicketUserData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "room_number": roomNumber,
    "room_capacity": roomCapacity,
    "room_type_name": roomTypeName,
    "stay_name": stayName,
    "guests": List<dynamic>.from(guests.map((x) => x.toJson())),
  };
}