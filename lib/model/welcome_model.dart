import 'package:demo_project/model/user_event_model.dart';
import 'package:flutter/cupertino.dart';

class Welcome extends ChangeNotifier{
  UserEvents userEvents;

  Welcome({
    required this.userEvents,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    userEvents: UserEvents.fromJson(json["user_events"]),
  );

  Map<String, dynamic> toJson() => {
    "user_events": userEvents.toJson(),
  };
}
