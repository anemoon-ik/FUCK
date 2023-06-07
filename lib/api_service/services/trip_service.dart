import 'package:besmart_traveler/api_service/urls.dart';

import '../../models/pagination.dart';
import '../../models/trip/Level.dart';
import '../../models/trip/location.dart';
import '../../models/trip/trip.dart';
import '../methods.dart';

const locations = Urls.baseApiUrl + Urls.locations;
const trips = Urls.baseApiUrl + Urls.trips;

class ApiTrip {
  static Future<Pagination?> getLevels() async {
    var body = await httpGet(Urls.baseApiUrl + Urls.levels);

    return body == null
        ? null
        : Pagination.fromJson(body, (json) => Level.fromJson(json));
  }

  static Future<Pagination?> getTrips([url = trips]) async {
    var body = await httpGet(url);

    return body == null
        ? null
        : Pagination.fromJson(body, (json) => Trip.fromJson(json));
  }

  static Future<Pagination?> getLocations([url = locations]) async {
    var body = await httpGet(url);
    return body == null
        ? null
        : Pagination.fromJson(body, (json) => Location.fromJson(json));
  }

  static Future<Location?> getLocation(url) async {
    var body = await httpGet(url);
    return body == null ? null : Location.fromJson(body);
  }

  static Future<List<LocationName>?> getAllLocations() async {
    var body = await httpGet(Urls.baseApiUrl + Urls.allLocations);
    return body
        ?.map<LocationName>((location) => LocationName.fromJson(location))
        .toList();
  }
}
