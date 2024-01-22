class Todo {
  String title;
  String description;
  bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        isCompleted: json["is_completed"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "is_completed": isCompleted,
      };
}
