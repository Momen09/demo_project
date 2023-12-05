import 'package:demo_project/model/ticket_user_data.dart';
import 'package:flutter/cupertino.dart';

class UserTicket extends ChangeNotifier {
  int ticketId;
  int seat;
  String ticketSystemId;
  String ticketTypeName;
  TicketUserData ticketUserData;
  int gate;

  UserTicket({
    required this.ticketId,
    required this.seat,
    required this.ticketSystemId,
    required this.ticketTypeName,
    required this.ticketUserData,
    required this.gate,
  });

  factory UserTicket.fromJson(Map<String, dynamic> json) => UserTicket(
    ticketId: json["ticket_id"],
    seat: json["seat"],
    ticketSystemId: json["ticket_system_id"],
    ticketTypeName: json["ticket_type_name"],
    ticketUserData: TicketUserData.fromJson(json["ticket_user_data"]),
    gate: json["gate"],
  );

  Map<String, dynamic> toJson() => {
    "ticket_id": ticketId,
    "seat": seat,
    "ticket_system_id": ticketSystemId,
    "ticket_type_name": ticketTypeName,
    "ticket_user_data": ticketUserData.toJson(),
    "gate": gate,
  };
}
