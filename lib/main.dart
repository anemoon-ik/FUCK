import 'package:besmart_traveler/utils/unfocus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';
import 'package:besmart_traveler/constants.dart';
import 'package:besmart_traveler/forms/companies.dart';
import 'package:besmart_traveler/forms/locations.dart';
import 'package:besmart_traveler/forms/client.dart';
import 'package:besmart_traveler/forms/user_details.dart';
import 'package:besmart_traveler/forms/search_trips.dart';
import 'package:besmart_traveler/redux/app_state.dart';
import 'package:besmart_traveler/redux/reducers/reducer.dart';
import 'package:besmart_traveler/utils/get_info.dart';
import 'package:redux/redux.dart';
import 'api_service/services/client_service.dart';
import 'models/client/client.dart';
import 'models/pagination.dart';
import 'models/user/User.dart';
import 'models/user/token.dart';
import 'router/router.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Token? token = await Token.isAuth();

  AppState initialStore = AppState(
    token: token,
    familyStatus: await ApiClient.getFamilyStatus(),
    workStatus: await ApiClient.getWorkStatus(),
    companies: Pagination(count: 0, results: []),
    locations: Pagination(count: 0, results: []),
    levels: Pagination(count: 0, results: []),
    trips: Pagination(count: 0, results: []),
    client: Client(),
    user: User(),
    searchTrips: SearchTripsForm(),
    clientForm: ClientForm(),
    userDetailsForm: UserDetailsForm(),
    locationsSearch: LocationsForm(),
    companiesForm: CompaniesForm(),
    allLocations: [],
    allCompanies: [],
  );

  final Store<AppState> store = Store(reducer, initialState: initialStore);

  if (token is Token) {
    getInfo(store, token);
  }

  runApp(
    StoreProvider(
      store: store,
      child: const MaterialApp(
        home: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    return StoreProvider(
      store: store,
      child: GestureDetector(
        onTap: () => unfocus(context),
        child: MaterialApp.router(
          title: appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.green,
            appBarTheme: const AppBarTheme(
              color: Colors.green, // Set the color to green
              systemOverlayStyle: SystemUiOverlayStyle(
                //<-- SEE HERE
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            ),
          ),
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
        ),
      ),
    );
  }
}
