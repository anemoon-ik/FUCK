import 'Company.dart';

class Phone {
  int id;
  final String number;
  final Company company;

  Phone({
    required this.id,
    required this.number,
    required this.company,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      id: json['id'],
      number: json['number'],
      company: Company.fromJson(json['company']),
    );
  }
}
