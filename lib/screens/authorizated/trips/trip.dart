import 'package:besmart_traveler/components/constants.dart';
import 'package:besmart_traveler/router/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:besmart_traveler/components/button.dart';
import 'package:redux/redux.dart';

import '../../../components/carouser.dart';
import '../../../components/company/company_card.dart';
import '../../../components/container.dart';
import '../../../components/icons.dart';
import '../../../components/text.dart';
import '../../../models/trip/trip.dart';
import '../../../redux/app_state.dart';
import '../../../utils/date.dart';
import '../../../utils/price.dart';
import '../../accessable/photo_view.dart';

String substring(String time) {
  return time.substring(0, 5);
}

Widget darkImageCard(Photo child) {
  return SizedBox(
    height: cardHeight,
    width: double.infinity,
    child: Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: cardHeight,
          child: child,
        ),
        IgnorePointer(
          child: Container(
            height: cardHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color.fromRGBO(0, 0, 0, 0.7),
                ],
                stops: [0.0, 1],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class TripPage extends StatefulWidget {
  final String? id;

  const TripPage({super.key, required this.id});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  late Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    Trip trip = store.state.trips.results.firstWhere(
      (c) => c.id.toString() == widget.id,
    );

    List<String> images = trip.files.map<String>((file) => file.file).toList();

    return Scaffold(
      bottomNavigationBar: bottomAppBar(
        context: context,
        currentPage: tripsPage,
      ),
      body: bodyContainer(
        top: 0,
        left: 0,
        right: 0,
        children: [
          Stack(
            children: [
              carousel(
                images: images,
                title: trip.name,
                imageCard: darkImageCard,
              ),
              Container(
                height: cardHeight,
                padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        iconButton(
                          context: context,
                          icon: Icons.arrow_back,
                          size: 40,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        // iconButton(
                        //   Icons.favorite_border,
                        //   () {},
                        // ),
                      ],
                    ),
                    IgnorePointer(
                      child: Column(
                        children: [
                          heading2W(trip.name),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buttonSm(
                                context: context,
                                text: showDate(
                                  trip.leavingDate,
                                  trip.arrivalDate,
                                ),
                                size: 0.5,
                              ),
                              sizedBox40,
                              buttonSm(
                                context: context,
                                text:
                                    "${substring(trip.leavingTime)} - ${substring(trip.arrivalTime)}",
                                size: 0.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                containerMargin(
                  bottom: 40,
                  child: heading2(showPrice(trip.price)),
                ),
                containerB10(child: heading4B('ЛОКАЦИИ')),
                containerB25(
                  child: Wrap(
                    children: trip.locations.map<Widget>((location) {
                      return Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: containerB10(
                          child: buttonSm(
                            context: context,
                            text: location.name,
                            onPressed: () {
                              GoRouter.of(context).push(
                                  '/authorizated/locations/${location.id}');
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                containerB10(child: heading4B('ОПИСАНИЕ')),
                containerB25(child: heading4("\t\t${trip.description}")),
                containerB10(child: heading4B('УРОВЕНЬ СЛОЖНОСТИ')),
                containerB25(
                  child: heading4(
                    "\t\t${trip.level.name} - ${trip.level.description}",
                  ),
                ),
                containerB20(
                  child: Row(
                    children: medias(
                      trip.company.phones,
                      trip.company.socialMedia,
                    ),
                  ),
                ),
                companyCard(context, trip.company),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
