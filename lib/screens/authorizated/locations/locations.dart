import 'package:besmart_traveler/router/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:besmart_traveler/components/button.dart';
import 'package:besmart_traveler/components/input.dart';
import 'package:redux/redux.dart';

import '../../../api_service/services/trip_service.dart';
import '../../../api_service/urls.dart';
import '../../../components/location/location_card.dart';
import '../../../components/container.dart';
import '../../../forms/locations.dart';
import '../../../models/trip/Location.dart';
import '../../../utils/scroll_bottom.dart';
import '../../../models/pagination.dart';
import '../../../redux/actions/pagination.dart';
import '../../../redux/app_state.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final ScrollController control = ScrollController();
  late Store<AppState> store;

  @override
  void initState() {
    super.initState();

    control.addListener(() {
      store = StoreProvider.of<AppState>(context);

      if (scrollBottom(control) && store.state.locations.next != null) {
        ApiTrip.getLocations(store.state.locations.next).then((pgn) {
          if (pgn is Pagination) {
            store.dispatch(UpdatePgn(name: Location.modelName, pgn: pgn));
          }
        });
      }
    });
  }

  void submit(Store store, BuildContext context) {
    LocationsForm form = store.state.locationsSearch;

    String url = "${Urls.baseApiUrl}${Urls.locations}?";
    url += "search=${form.location.text}&";

    if (form.level > 0) {
      url += "level=${form.level}";
    }

    ApiTrip.getLocations(url).then((pgn) {
      if (pgn != null) {
        store.dispatch(SetPgn(name: Location.modelName, pgn: pgn));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    LocationsForm form = store.state.locationsSearch;
    List<List<Object>> levels = store.state.levels.results
        .map<List<Object>>((e) => [e.id, e.name])
        .toList();
    levels = [
          [-1, 'Все уровни']
        ] +
        levels;

    return Scaffold(
      bottomNavigationBar:
          bottomAppBar(context: context, currentPage: locationsPage),
      body: bodyContainer(
        controller: control,
        children: [
          Form(
            child: Column(
              children: [
                selectField(
                  label: 'Уровень',
                  selected: form.level,
                  options: levels,
                  onChange: (newValue) => form.level = newValue,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: input(controller: form.location, text: 'Название'),
                    ),
                    const SizedBox(width: 10),
                    containerB20(
                      child: buttonSm(
                        context: context,
                        text: '↻',
                        onPressed: () {
                          store.state.locationsSearch = LocationsForm();
                          submit(store, context);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    containerB20(
                      child: buttonSm(
                        context: context,
                        text: 'Поиск',
                        onPressed: () => submit(store, context),
                        active: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return Column(
                children: state.locations.results
                    .map((e) => locationCard(context, e))
                    .toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
