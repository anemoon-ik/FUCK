class Level {
  Level({
    required this.id,
    required this.name,
    required this.description,
  });

  int id;
  String name;
  String description;
  static String modelName = 'Level';

  factory Level.fromJson(Map json) => Level(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );
}