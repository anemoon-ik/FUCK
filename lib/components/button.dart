import 'package:flutter/material.dart';

import '../utils/unfocus.dart';
import 'constants.dart';
import 'container.dart';
import 'text.dart';

Widget button({
  required BuildContext context,
  required dynamic text,
  required Function onPressed,
  double size = 1,
  dynamic color = color,
  IconData? icon,
}) {
  return containerB15(
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            roundedBorderRaduis),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        minimumSize: MaterialStateProperty.all<Size>(
            Size(size * MediaQuery.of(context).size.width, 48)),
      ),
      onPressed: () {
        unfocus(context);
        onPressed();
      },
      child: icon == null
          ? heading3(text)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: text == ""
                  ? [Icon(icon)]
                  : [Icon(icon), const SizedBox(width: 10), heading3(text)],
            ),
    ),
  );
}

Widget buttonSm({
  required BuildContext context,
  required String text,
  Function? onPressed,
  bool active = false,
  double size = 1,
}) {
  return ElevatedButton(
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            roundedBorderRaduis),
        backgroundColor: active
            ? MaterialStateProperty.all<Color>(colorLight)
            : MaterialStateProperty.all<Color>(Colors.grey.shade100),
        foregroundColor: active
            ? MaterialStateProperty.all<Color>(Colors.white)
            : MaterialStateProperty.all<Color>(Colors.black)),
    onPressed: () {
      unfocus(context);
      onPressed!();
    },
    child: Padding(
      padding: EdgeInsets.all(10.0 * size),
      child: heading4(text),
    ),
  );
}

Widget iconButton({
  required IconData icon,
  required Function onPressed,
  required BuildContext context,
  double size=30,
}) {
  return InkWell(
    onTap: () {
      unfocus(context);
      onPressed();
    },
    child: Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(
        icon,
        color: Colors.black,
        size: 14,
      ),
    ),
  );
}
