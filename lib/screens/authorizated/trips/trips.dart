import 'package:besmart_traveler/router/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:redux/redux.dart';
import 'package:intl/intl.dart';

import '../../../api_service/services/trip_service.dart';
import '../../../api_service/urls.dart';
import '../../../components/button.dart';
import '../../../components/constants.dart';
import '../../../components/container.dart';
import '../../../components/multiselect.dart';
import '../../../components/trip/trip_card.dart';
import '../../../forms/search_trips.dart';
import '../../../models/trip/trip.dart';
import '../../../redux/actions/pagination.dart';
import '../../../redux/app_state.dart';
import 'filters.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  String today = DateFormat('dd.MM.yyyy').format(DateTime.now());
  bool showFilters = false;
  final formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Column showTrips(Store store) {
    List trips = store.state.trips.results;

    return Column(
      children: [
        Column(
          children: trips.map<Widget>((e) => tripCard(context, e)).toList(),
        ),
      ],
    );
  }

  void navigateToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void submit(Store store, SearchTripsForm form, [String action = "search"]) {
    if (showFilters == false || formKey.currentState!.validate()) {
      String url = "${Urls.baseApiUrl}${Urls.trips}?";

      url += "price__gte=${form.minPriceText.text}&";
      url += "price__lte=${form.maxPriceText.text}&";
      url += "leaving_date__gte=${form.dateStartCont.text}&";
      url += "arrival_date__lte=${form.dateEndCont.text}&";
      url += 'leaving_time__gte=${form.timeStartCont}&';
      url += 'arrival_time__lte=${form.timeEndCont}&';
      url += 'level__in=${form.selectedLevels.join(',')}&';
      url += 'company__in=${form.selectedCompanies.join(',')}&';
      url += 'triplocation__location__in=${form.selectedLocations.join(',')}&';

      ApiTrip.getTrips(url).then((pgn) {
        if (pgn != null) {
          store.dispatch(SetPgn(name: Trip.modelName, pgn: pgn));
          setState(() {
            if (action == "search") {
              showFilters = false;
            }
            navigateToTop();
          });
        }
      });
    } else {
      navigateToTop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    void toggleListValue(list, name) {
      name = name.toString();
      setState(() {
        list.contains(name) ? list.remove(name) : list.insert(0, name);
      });
    }

    Form filters(Store store) {
      dynamic state = store.state;
      SearchTripsForm form = store.state.searchTrips;

      void reload(v) => setState(() {});

      List locations = multiSelect(
        options: state.allLocations,
        controller: form.searchLocation,
        selected: form.selectedLocations,
      );

      List companies = multiSelect(
        options: state.companies.results,
        controller: form.searchCompany,
        selected: form.selectedCompanies,
      );

      List<Widget> listWid(List results, List selected) {
        return results.map<Widget>((result) {
          return buttonSm(
              context: context,
              text: result.name,
              onPressed: () => toggleListValue(selected, result.id),
              active: selected.contains(result.id.toString()));
        }).toList();
      }

      List<Widget> levelsWid =
          listWid(state.levels.results, form.selectedLevels);
      List<Widget> locationsWid = listWid(locations, form.selectedLocations);
      List<Widget> companiesWid = listWid(companies, form.selectedCompanies);

      return filtersForm(formKey, context, form, reload, levelsWid,
          locationsWid, companiesWid, submit, store);
    }

    return Scaffold(
      bottomNavigationBar:
          bottomAppBar(context: context, currentPage: tripsPage),
      body: bodyContainer(controller: scrollController, children: [
        containerB20(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buttonSm(
                context: context,
                text: 'Фильтры',
                onPressed: () => setState(() => showFilters = !showFilters),
                active: showFilters,
              ),
              sizedBox10,
              buttonSm(
                context: context,
                text: '↻',
                onPressed: () {
                  store.state.searchTrips = SearchTripsForm();
                  if (showFilters) {
                    formKey.currentState!.reset();
                  }
                  submit(store, store.state.searchTrips, "reset");
                },
                active: false,
              ),
            ],
          ),
        ),
        showFilters ? filters(store) : showTrips(store),
      ]),
    );
  }
}
