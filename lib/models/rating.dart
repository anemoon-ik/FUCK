import 'package:besmart_traveler/models/trip/Location.dart';
import 'package:besmart_traveler/models/trip/trip.dart';

import 'company/Company.dart';

class RatingLocation {
  final Location location;

  RatingLocation({
    required this.location,
  });

  factory RatingLocation.fromJson(Map<String, dynamic> json) {
    return RatingLocation(
      location: Location.fromJson(json['location']),
    );
  }
}

class RatingTrip {
  final Trip trip;

  RatingTrip({
    required this.trip,
  });

  factory RatingTrip.fromJson(Map<String, dynamic> json) {
    return RatingTrip(
      trip: Trip.fromJson(json['trip']),
    );
  }
}

class RatingCompany {
  final Company company;

  RatingCompany({
    required this.company,
  });

  factory RatingCompany.fromJson(Map<String, dynamic> json) {
    return RatingCompany(
      company: Company.fromJson(json['company']),
    );
  }
}