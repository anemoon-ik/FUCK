import 'package:flutter/material.dart';
import 'package:besmart_traveler/components/text.dart';

AppBar appBar({
  required BuildContext context,
  String title = '',
  Function? setState,
}) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      color: Colors.black,
      onPressed: () {
        if (setState != null) {
          setState();
        }
        Navigator.of(context).pop();
      },
    ),
    centerTitle: true,
    title: heading2(title),
  );
}
