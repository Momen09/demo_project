
class TicketUserData {
  String firstName;
  String lastName;
  String avatar;
  bool? isUser;

  TicketUserData({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.isUser,
  });

  factory TicketUserData.fromJson(Map<String, dynamic> json) => TicketUserData(
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
    isUser: json["is_user"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
    "is_user": isUser,
  };
}
