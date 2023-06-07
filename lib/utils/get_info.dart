import 'package:redux/redux.dart';

import '../api_service/services/user_service.dart';
import '../api_service/services/client_service.dart';
import '../api_service/services/company_service.dart';
import '../api_service/services/trip_service.dart';
import '../models/company/Company.dart';
import '../models/pagination.dart';
import '../models/trip/Level.dart';
import '../models/trip/location.dart';
import '../models/trip/trip.dart';
import '../models/user/token.dart';
import '../redux/actions/pagination.dart';

void getInfo(Store store, Token token) {
  ApiTrip.getLevels().then((pgn) {
    if (pgn is Pagination) {
      store.dispatch(SetPgn(name: Level.modelName, pgn: pgn));
    }
  });

  ApiTrip.getLocations().then((pgn) {
    if (pgn is Pagination) {
      store.dispatch(SetPgn(name: Location.modelName, pgn: pgn));
    }
  });

  ApiCompany.getCompanies().then((pgn) {
    if (pgn is Pagination) {
      store.dispatch(SetPgn(name: Company.modelName, pgn: pgn));
    }
  });

  ApiTrip.getTrips().then((pgn) {
    if (pgn is Pagination) {
      store.dispatch(SetPgn(name: Trip.modelName, pgn: pgn));
    }
  });

  ApiTrip.getAllLocations().then((locations) {
    if (locations is List<LocationName>) {
      store.state.allLocations = locations;
    }
  });

  ApiCompany.getAllCompanies().then((companies) {
    if (companies is List<CompanyName>) {
      store.state.allCompanies = companies;
    }
  });

  ApiClient.getClientInfo(token).then((client) {
    store.state.client = client;
    store.state.clientForm.dateOfBirth.text = client.dateOfBirth;
    store.state.clientForm.phoneNumber.text = client.phoneNumber;
    store.state.clientForm.gender = client.gender;
    store.state.clientForm.workStatus = client.workStatus;
    store.state.clientForm.familyStatus = client.familyStatus;
  });

  ApiUser.getUserInfo(token).then((user) {
    store.state.user = user;

    store.state.userDetailsForm.firstName.text = user.firstName;
    store.state.userDetailsForm.lastName.text = user.lastName;
  });
}
