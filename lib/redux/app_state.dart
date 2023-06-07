import 'package:besmart_traveler/forms/locations.dart';
import 'package:besmart_traveler/forms/client.dart';
import 'package:besmart_traveler/models/company/Company.dart';
import 'package:besmart_traveler/models/pagination.dart';
import 'package:besmart_traveler/models/user/token.dart';

import '../forms/companies.dart';
import '../forms/user_details.dart';
import '../forms/search_trips.dart';
import '../models/client/client.dart';
import '../models/trip/location.dart';
import '../models/user/User.dart';

class AppState {
  Pagination workStatus;
  Pagination familyStatus;
  Pagination companies;
  Pagination locations;
  Pagination trips;
  Pagination levels;
  Token? token;
  Client client;
  User user;
  SearchTripsForm searchTrips;
  UserDetailsForm userDetailsForm;
  ClientForm clientForm;
  LocationsForm locationsSearch;
  CompaniesForm companiesForm;
  List<LocationName> allLocations;
  List<CompanyName> allCompanies;

  AppState({
    required this.workStatus,
    required this.familyStatus,
    this.token,
    required this.companies,
    required this.locations,
    required this.trips,
    required this.levels,
    required this.client,
    required this.user,
    required this.searchTrips,
    required this.clientForm,
    required this.userDetailsForm,
    required this.locationsSearch,
    required this.companiesForm,
    required this.allLocations,
    required this.allCompanies,
  });
}
