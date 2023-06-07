import 'package:flutter/material.dart';
import 'package:besmart_traveler/components/container.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:go_router/go_router.dart';

import '../../models/company/company.dart';
import '../constants.dart';


Widget companyCard(BuildContext context, Company company) {
  return containerB20(
    child: InkWell(
      onTap: () {
        GoRouter.of(context).push('/authorizated/companies/${company.id}');
      },
      child: Card(
        shape: roundedBorderRaduis,
        child: Row(
          children: [
            // TODO: image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                image: DecorationImage(
                  image: NetworkImage(company.logo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            sizedBox20,
            heading4B(company.name),
          ],
        ),
      ),
    ),
  );
}
