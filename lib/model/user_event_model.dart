import 'package:demo_project/model/reservation_model.dart';
import 'package:demo_project/model/user_ticket.dart';
import 'package:flutter/cupertino.dart';

class UserEvents {
  List<Reservation> reservations;
  List<UserTicket> userTickets;

  UserEvents({
    required this.reservations,
    required this.userTickets,
  });

  factory UserEvents.fromJson(Map<String, dynamic> json) => UserEvents(
    reservations: List<Reservation>.from(json["reservations"].map((x) => Reservation.fromJson(x))),
    userTickets: List<UserTicket>.from(json["user_tickets"].map((x) => UserTicket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "reservations": List<dynamic>.from(reservations.map((x) => x.toJson())),
    "user_tickets": List<dynamic>.from(userTickets.map((x) => x.toJson())),
  };
}