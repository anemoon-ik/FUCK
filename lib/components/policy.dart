import 'package:flutter/material.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:besmart_traveler/router/urls.dart';
import 'package:go_router/go_router.dart';

import 'container.dart';

Widget policyBlock(BuildContext context) {
  return containerB15(
    child: Row(
      children: [
        heading6('Продолжая, я соглашаюсь с'),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: InkWell(
            onTap: () {
              context.pushNamed(policyPage);
            },
            child: heading6B(' пользовательским соглашением'),
          ),
        ),
      ],
    ),
  );
}
