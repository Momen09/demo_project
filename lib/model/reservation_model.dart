import 'package:demo_project/model/stay_model.dart';
import 'package:flutter/cupertino.dart';

class Reservation {
  int id;
  DateTime startDate;
  DateTime endDate;
  List<Stay> stays;

  Reservation({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.stays,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    id: json["id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    stays: List<Stay>.from(json["stays"].map((x) => Stay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "stays": List<dynamic>.from(stays.map((x) => x.toJson())),
  };
}
