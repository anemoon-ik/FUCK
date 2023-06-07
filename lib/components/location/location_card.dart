import 'package:flutter/material.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:go_router/go_router.dart';

import '../../api_service/urls.dart';
import '../../models/trip/location.dart';

Widget locationCard(BuildContext context, Location location) {
  return InkWell(
    onTap: () =>
        GoRouter.of(context).push('/authorizated/locations/${location.id}'),
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 184,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(Urls.baseUrl + location.files[0].file).image,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0x65090F13),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: heading2W(location.name),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            heading3W(location.level.name),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
