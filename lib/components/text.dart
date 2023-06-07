import 'package:flutter/material.dart';

import 'container.dart';

Container heading1(String text) {
  return containerB5(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.green[700],
        fontFamily: 'Roboto',
        fontSize: 36.0,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Text heading2C(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.green,
      fontFamily: 'Roboto',
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      height: 1.5,
    ),
  );
}

Text heading2(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: Colors.black),
  );
}

Container heading2W(String text) {
  return containerB15(
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: Colors.white,
      ),
    ),
  );
}

Text heading3(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
  );
}

Text heading3W(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: Colors.white),
  );
}

Text heading4(String text) {
  return Text(
    text,
    textAlign: TextAlign.justify,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
  );
}

Text heading4W(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
  );
}

Text heading4B(String text, {TextAlign align=TextAlign.justify}) {
  return Text(
    text,
    textAlign: TextAlign.justify,
    style: const TextStyle(
        // fontFamily: 'Lobster',
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: Colors.black),
  );
}

Text heading5(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
  );
}

Widget heading6(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
  );
}

Widget heading6C(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: Colors.green,
    ),
  );
}

Text heading6B(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      height: 1.5,
    ),
  );
}

Text redText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.redAccent,
      height: 1.5,
    ),
  );
}
