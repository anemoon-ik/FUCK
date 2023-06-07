import 'package:flutter/material.dart';

Container containerMargin({
  required Widget? child,
  double bottom = 0.0,
  double top = 0.0,
  double left = 0.0,
  double right = 0.0,
}) {
  return Container(
    // width: double.infinity,
    margin: EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
    child: child,
  );
}

SizedBox container(child) {
  return SizedBox(
    width: double.infinity,
    child: child,
  );
}

Container containerB25({required Widget child}) {
  return containerMargin(child: child, bottom: 25);
}

Container containerB20({required Widget child}) {
  return containerMargin(child: child, bottom: 20);
}

Container containerB10({Widget? child}) {
  return containerMargin(child: child, bottom: 10);
}

Container containerB5({required Widget child}) {
  return containerMargin(child: child, bottom: 5);
}

Container containerB15({required Widget child}) {
  return containerMargin(child: child, bottom: 15);
}

SingleChildScrollView bodyContainer({
  required List<Widget> children,
  controller,
  double top = 60,
  double left = 30,
  double right = 30,
  double bottom = 20,
}) {
  return SingleChildScrollView(
    controller: controller,
    child: containerMargin(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
      bottom: bottom,
      top: top,
      left: left,
      right: right,
    ),
  );
}
