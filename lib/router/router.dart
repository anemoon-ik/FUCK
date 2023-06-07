import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/router/utils/GoRouteItem.dart';
import 'package:besmart_traveler/screens/auth/login.dart';
import 'package:besmart_traveler/screens/auth/registration/verify_code.dart';
import 'package:besmart_traveler/screens/authorizated/companies/company.dart';
import 'package:besmart_traveler/screens/authorizated/locations/locations.dart';
import 'package:besmart_traveler/screens/accessable/welcome.dart';
import 'package:besmart_traveler/screens/auth/auth.dart';
import 'package:besmart_traveler/screens/authorizated/home.dart';
import 'package:besmart_traveler/screens/authorizated/trips/trip.dart';
import 'package:redux/redux.dart';

import '../models/user/token.dart';
import '../redux/app_state.dart';
import '../screens/accessable/help.dart';
import '../screens/accessable/policy.dart';
import '../screens/auth/registration/registation_user.dart';
import '../screens/auth/registration/registration_client.dart';
import '../screens/auth/registration/verify_number.dart';
import '../screens/authorizated/account/account.dart';
import '../screens/authorizated/account/client_info.dart';
import '../screens/authorizated/account/user_info.dart';
import '../screens/authorizated/companies/companies.dart';
import '../screens/authorizated/locations/location.dart';
import '../screens/authorizated/trips/trips.dart';
import './urls.dart';

List<String> loginRequiredUrls = [
  homePage,
  tripsPage,
  locationsPage,
  companiesPage,
  accountPage
];

List<String> loginNotRequiredUrls = [
  welcomePage,
  authPage,
  loginPage,
  registerUserPage,
  registerClientPage,
  verifyNumPage,
];

final router = GoRouter(
  debugLogDiagnostics: false,
  routes: [
    // welcome
    route(welcomePage, const WelcomePage()),
    route(policyPage, const Policy()),
    route(helpPage, const HelpPage()),

    // auth
    route(authPage, const AuthPage()),
    route(loginPage, const LoginPage()),
    route(registerUserPage, const RegisterUserPage()),
    route(registerClientPage, const RegisterClientPage()),
    route(verifyNumPage, const VerifyNumberPage()),
    route(verifyCodePage, const VerifyCodePage()),
    // app
    route(homePage, const HomePage()),
    route(tripsPage, const Trips()),
    route(locationsPage, const LocationsPage()),
    route(companiesPage, const CompaniesPage()),
    route(accountPage, const AccountPage()),
    route(accountUserDetailPage, const AccountUserDetailPage()),
    route(accountClientDetailPage, const AccountClientPage()),

    GoRoute(
      name: locationPage,
      path: locationPage,
      builder: (context, state) {
        return LocationPage(id: state.params['id']);
      },
    ),

    GoRoute(
      name: companyPage,
      path: companyPage,
      builder: (context, state) {
        return CompanyPage(id: state.params['id']);
      },
    ),

    GoRoute(
      name: tripPage,
      path: tripPage,
      builder: (context, state) {
        return TripPage(id: state.params['id']);
      },
    ),
  ],
  redirect: (context, state) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    Token? token = store.state.token;

    if (token is Token && loginNotRequiredUrls.contains(state.subloc)) {
      return homePage;
    }
    if (token == null && loginRequiredUrls.contains(state.subloc)) {
      return welcomePage;
    }

    return null;
  },
);
