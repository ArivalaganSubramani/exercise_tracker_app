import 'dart:convert';

List<Exercise> exerciseFromJson(String str) => List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

String exerciseToJson(List<Exercise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exercise {
  String name;
  String description;
  int duration;
  String difficulty;
  String id;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.id,
    this.isCompleted = false,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    name: json["name"],
    description: json["description"],
    duration: json["duration"],
    difficulty: json["difficulty"],
    id: json["id"],
    isCompleted: json.containsKey("isCompleted")
        ? json["isCompleted"]
        : false,

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "duration": duration,
    "difficulty": difficulty,
    "id": id,
    "isCompleted": isCompleted,
  };
}
