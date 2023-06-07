import '../file.dart';
import 'Level.dart';

class LocationName {
  int id;
  String name;

  LocationName({
    required this.id,
    required this.name,
  });

  factory LocationName.fromJson(Map<String, dynamic> json) {
    return LocationName(
      id: json["id"],
      name: json["name"],
    );
  }
}

class Location {
  int id;
  String name;
  String description;
  Level level;
  List files;
  static String modelName = 'Location';

  Location({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.files,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      level: Level.fromJson(json["level"]),
      files: json["files"].map((file) => File.fromJson(file)).toList(),
    );
  }
}
