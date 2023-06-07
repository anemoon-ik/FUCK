import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:besmart_traveler/utils/price.dart';

import '../../models/trip/trip.dart';
import '../../utils/date.dart';
import '../button.dart';
import '../constants.dart';
import '../container.dart';

Widget tripCard(BuildContext context, Trip trip) {
  return containerB20(
    child: InkWell(
      onTap: () {
        GoRouter.of(context).push('/authorizated/trips/${trip.id}');
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 3.0,
          shape: roundedBorderRaduis,
          child: Padding(
            padding: paddind20,
            child: Column(
              children: [
                containerB20(
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Image.network(
                      trip.files[0].file,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                containerB20(child: heading2(trip.name)),
                containerB20(
                  child: heading4(
                    showDateWithDay(trip.leavingDate, trip.arrivalDate),
                  ),
                ),
                button(
                  context: context,
                  text: showPrice(trip.price),
                  onPressed: () {
                    GoRouter.of(context).push('/authorizated/trips/${trip.id}');
                  },
                  size: 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
