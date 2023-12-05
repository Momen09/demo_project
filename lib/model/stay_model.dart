import 'package:demo_project/model/room_model.dart';
import 'package:flutter/cupertino.dart';

class Stay  {
  String name;
  String description;
  double lat;
  double ? lng;
  String address;
  String checkIn;
  String checkOut;
  int stars;
  List<String> stayImages;
  String amenities;
  List<Room> rooms;

  Stay({
    required this.name,
    required this.description,
    required this.lat,
    required this.lng,
    required this.address,
    required this.checkIn,
    required this.checkOut,
    required this.stars,
    required this.stayImages,
    required this.amenities,
    required this.rooms,
  });

  factory Stay.fromJson(Map<String, dynamic> json) => Stay(
    name: json["name"],
    description: json["description"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    address: json["address"],
    checkIn: json["check_in"],
    checkOut: json["check_out"],
    stars: json["stars"],
    stayImages: List<String>.from(json["stay_images"].map((x) => x)),
    amenities: json["amenities"],
    rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "lat": lat,
    "lng": lng,
    "address": address,
    "check_in": checkIn,
    "check_out": checkOut,
    "stars": stars,
    "stay_images": List<dynamic>.from(stayImages.map((x) => x)),
    "amenities": amenities,
    "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
  };
}