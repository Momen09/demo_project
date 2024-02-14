class Todo {
  String title;
  String description;
  bool isCompleted;
  String id;

  Todo({
    required this.title,
    required this.id,
    required this.description,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        id: json["_id"] ?? '',
        isCompleted: json["is_completed"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "is_completed": isCompleted,
        "_id": id,
      };
}
