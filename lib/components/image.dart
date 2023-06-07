import 'package:flutter/cupertino.dart';

import '../screens/accessable/photo_view.dart';

Widget imageCard(Photo child) {
  return Container(
    height: 300,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      child: child,
    ),
  );
}
