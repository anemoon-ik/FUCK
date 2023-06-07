import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

import 'package:besmart_traveler/components/button.dart';
import 'package:besmart_traveler/components/container.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/app_bar.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context),
        body: bodyContainer(
          children: [
            containerB20(child: heading4B('Служба поддержки')),
            Container(
              margin: const EdgeInsets.only(top: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  containerB20(
                    child: SvgPicture.asset(
                      'assets/images/questions.svg',
                      width: 300,
                    ),
                  ),
                  containerB20(
                    child: heading4(
                        'Наша служба поддержки постарается вам ответить на ваш вопрос'),
                  ),
                  button(
                    context: context,
                    text: 'Telegram',
                    onPressed: () => launchUrl(
                      // TODO: URI for different links
                      Uri.parse("tg://resolve?domain=besmarttraveler"),
                    ),
                    size: 1,
                    color: const Color(0xFF0088CC),
                    icon: FontAwesome.telegram,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
