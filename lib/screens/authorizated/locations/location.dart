import 'package:besmart_traveler/components/carouser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:besmart_traveler/api_service/services/trip_service.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:besmart_traveler/components/image.dart';
import 'package:redux/redux.dart';

import '../../../api_service/urls.dart';
import '../../../components/app_bar.dart';
import '../../../components/container.dart';
import '../../../components/text.dart';
import '../../../models/trip/location.dart';
import '../../../redux/app_state.dart';
import '../../../router/urls.dart';

class LocationPage extends StatefulWidget {
  final String? id;

  const LocationPage({super.key, required this.id});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Store<AppState> store;
  late Location location;
  String status = 'none';

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    Location? searchLocation = store.state.locations.results.firstWhere(
      (l) => l.id.toString() == widget.id,
      orElse: () => null,
    );

    if (searchLocation == null) {
      ApiTrip.getLocation(
        Urls.baseApiUrl + Urls.locations + widget.id.toString(),
      ).then((value) {
        if (value is Location) {
          store.state.locations.results.add(value);
          setState(() {
            location = value;
            status = 'found';
          });
        }
      });
    } else {
      location = searchLocation;
      status = 'found';
    }

    if (status == 'none') {
      return Container();
    }

    List<String> images =
        location.files.map<String>((file) => Urls.baseUrl + file.file).toList();

    return Scaffold(
      bottomNavigationBar: bottomAppBar(
        context: context,
        currentPage: locationsPage,
      ),
      appBar: appBar(context: context),
      body: bodyContainer(
        children: [
          heading2(location.name),
          containerB15(child: heading5("Уровень - ${location.level.name}")),
          containerB20(
            child: carousel(
              images: images,
              title: location.name,
              imageCard: imageCard,
            ),
          ),
          containerB20(child: heading4("    ${location.description}")),
        ],
      ),
    );
  }
}
