import 'package:besmart_traveler/forms/client.dart';
import 'package:besmart_traveler/forms/companies.dart';
import 'package:besmart_traveler/forms/locations.dart';
import 'package:besmart_traveler/forms/user_details.dart';
import 'package:besmart_traveler/redux/reducers/trip/location_reducer.dart';
import 'package:besmart_traveler/redux/reducers/client/family_status_reducer.dart';
import 'package:besmart_traveler/redux/reducers/trip/trip_reducer.dart';
import 'package:besmart_traveler/redux/reducers/user/user_reducer.dart';
import 'package:besmart_traveler/redux/reducers/client/work_status_reducer.dart';

import '../../forms/search_trips.dart';
import '../actions/auth.dart';
import '../app_state.dart';
import 'user/token_reducer.dart';
import 'client/client_reducer.dart';
import 'company/company_reducer.dart';
import 'trip/level_reducer.dart';

AppState reducer(AppState state, dynamic action) => AppState(
      token: tokenReducer(state, action),
      workStatus: workStatusReducer(state, action),
      familyStatus: familyStatusReducer(state, action),
      companies: companyReducer(state, action),
      locations: locationReducer(state, action),
      levels: levelReducer(state, action),
      trips: tripReducer(state, action),
      client: clientReducer(state, action),
      user: userReducer(state, action),

      allLocations: state.allLocations,
      allCompanies: state.allCompanies,
      // forms
      searchTrips: action is Logout ? SearchTripsForm(): state.searchTrips,
      userDetailsForm:  action is Logout ? UserDetailsForm(): state.userDetailsForm,
      clientForm:  action is Logout ? ClientForm() : state.clientForm,
      locationsSearch:  action is Logout ? LocationsForm(): state.locationsSearch,
      companiesForm: action is Logout ? CompaniesForm() : state.companiesForm,
    );
