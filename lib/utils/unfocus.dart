import 'package:flutter/material.dart';

void unfocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    FocusScope.of(context).requestFocus(FocusNode());
    currentFocus.unfocus();
  }
}
