import '../company/company.dart';
import '../file.dart';
import 'Level.dart';
import 'Location.dart';

class Trip {
  static String modelName = 'Trip';
  int id;
  String name;
  String description;
  String leavingTime;
  String arrivalTime;
  String leavingDate;
  String arrivalDate;
  String createdAt;
  String updatedAt;
  int price;
  Level level;
  List<Location> locations;
  List<File> files;
  Company company;

  Trip({
    required this.id,
    required this.name,
    required this.description,
    required this.leavingTime,
    required this.arrivalTime,
    required this.leavingDate,
    required this.arrivalDate,
    required this.price,
    required this.level,
    required this.locations,
    required this.company,
    required this.files,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        leavingTime: json['leaving_time'],
        arrivalTime: json['arrival_time'],
        leavingDate: json['leaving_date'],
        arrivalDate: json['arrival_date'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        price: json['price'],
        level: Level.fromJson(json["level"]),
        locations: json['locations']
            .map<Location>((location) => Location.fromJson(location))
            .toList(),
        files: json['files']
            .map<File>((file) => File.fromJson(file))
            .toList(),
        company: Company.fromJson(json['company']),
      );
}
