import 'package:besmart_traveler/models/user/User.dart';
import 'package:besmart_traveler/models/company/social_media.dart';

class CompanyName {
  int id;
  final String name;

  CompanyName({
    required this.id,
    required this.name,
  });

  factory CompanyName.fromJson(Map<String, dynamic> json) {
    return CompanyName(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Company {
  static String modelName = 'Company';
  int id;
  final String name;
  final String description;
  final String logo;
  final User? user;
  final List<dynamic> socialMedia;
  final List<String> phones;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.socialMedia,
    required this.phones,
    this.user,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
      phones: json['phone_set'].map((phone) => phone['number']).cast<String>().toList(),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      socialMedia: json['social_media_company']
          .map<SocialMedia>((media) => SocialMedia.fromJson(media))
          .toList(),
    );
  }
}
