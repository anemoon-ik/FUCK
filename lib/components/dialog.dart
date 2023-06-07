import 'dart:async';

import 'package:besmart_traveler/components/button.dart';
import 'package:besmart_traveler/components/constants.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:flutter/material.dart';

import 'container.dart';

Future<dynamic> dialog({
  required BuildContext context,
  Completer? completer,
  String title = "",
  TextAlign titleAlign =TextAlign.center,
  String description = "",
  bool buttonAction = false,
  List<Widget> children = const [],
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: roundedBorderRaduis,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                    title == ""
                        ? Container()
                        : containerB20(
                            child: heading4B(title, align: titleAlign),
                          ),
                    description == ""
                        ? Container()
                        : containerB20(
                            child: heading4(description),
                          ),
                    buttonAction
                        ? buttonSm(
                            context: context,
                            text: 'Понятно',
                            onPressed: () {
                              Navigator.of(context).pop();
                              completer?.complete();
                            },
                          )
                        : Container()
                  ] +
                  children,
            )),
      );
    },
  );
}
