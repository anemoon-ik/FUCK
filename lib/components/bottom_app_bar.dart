import 'package:besmart_traveler/utils/unfocus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:besmart_traveler/router/urls.dart';

Column item({
  required String title,
  required IconData icon,
  required BuildContext context,
  required String page,
  required bool active,
}) {

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: Icon(
          icon,
          color: active ? Colors.green : Colors.grey.shade700,
        ),
        splashRadius: 20,
        onPressed: () {
          unfocus(context);
          if (!active || ModalRoute.of(context)?.settings.name != page) {
            context.pushNamed(page);
          }
        },
      ),
      active ? heading6C(title) : heading6(title),
    ],
  );
}

BottomAppBar bottomAppBar({
  required BuildContext context,
  required String currentPage,
}) {
  return BottomAppBar(
    child: SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          item(
            title: 'Главная',
            icon: Icons.home,
            context: context,
            page: homePage,
            active: currentPage == homePage,
          ),
          item(
            title: 'Туры',
            icon: Icons.search,
            context: context,
            page: tripsPage,
            active: currentPage == tripsPage,
          ),
          item(
            title: 'Локации',
            icon: Icons.location_on,
            context: context,
            page: locationsPage,
            active: currentPage == locationsPage,
          ),
          item(
            title: 'Компании',
            icon: Icons.store,
            context: context,
            page: companiesPage,
            active: currentPage == companiesPage,
          ),
          item(
            title: 'Профиль',
            icon: Icons.person,
            context: context,
            page: accountPage,
            active: currentPage == accountPage,
          ),
        ],
      ),
    ),
  );
}
