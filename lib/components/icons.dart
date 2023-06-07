import 'package:besmart_traveler/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

Widget wrapperIcon({
  required Widget icon,
  required String url,
  required List<Color> colors,
  String? urlWeb,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 15),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            launchUrl(Uri.parse(url));
          } else if (urlWeb is String &&
              await canLaunchUrl(Uri.parse(urlWeb))) {
            launchUrl(
              Uri.parse(urlWeb),
              mode: LaunchMode.externalApplication,
            );
          }
        },
        child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.repeated,
                colors: colors,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            width: 45,
            height: 45,
            child: icon),
      ),
    ),
  );
}

Widget instragram({required String url}) {
  return wrapperIcon(
    icon: const Icon(
      FontAwesome.instagram,
      color: Colors.white,
      size: 28,
    ),
    url: "instagram://user?username=$url",
    colors: const [
      Color(0xFFFCAF45),
      Color(0xFFF77737),
      Color(0xFFE4405F),
      Color(0xFF833AB4),
      Color(0xFF405DE6),
    ],
    urlWeb: "https://www.instagram.com/$url/",
  );
}

Widget whatsapp({required String url}) {
  return wrapperIcon(
      icon: const Icon(
        FontAwesome.whatsapp,
        color: Colors.white,
        size: 28,
      ),
      url: 'whatsapp://send?phone=$url',
      colors: const [
        Color(0xFF25D366),
        Color(0xFF25D366),
      ],
      urlWeb: 'https://wa.me/?phone=$url');
}

Widget youtube({required String url}) {
  return wrapperIcon(
    icon: const Icon(
      FontAwesome.youtube,
      color: Colors.white,
      size: 28,
    ),
    url: url,
    colors: const [
      Color(0xFFFF0000),
      Color(0xFFFF0000),
    ],
  );
}

Widget facebook({required String url}) {
  return wrapperIcon(
    icon: const Icon(
      FontAwesome.facebook,
      color: Colors.white,
      size: 28,
    ),
    url: url,
    colors: const [
      Color(0xFF1877F2),
      Color(0xFF1877F2),
    ],
  );
}

Widget phone({required String url}) {
  return wrapperIcon(
    icon: const Icon(
      FontAwesome.phone,
      color: Colors.white,
      size: 28,
    ),
    url: 'tel:$url',
    colors: const [
      color,
      Color(0xFF25D366),
    ],
  );
}

Widget unknown({required String url}) {
  return wrapperIcon(
      icon: const Icon(
        FontAwesome.question,
        color: Colors.white,
        size: 28,
      ),
      url: url,
      colors: const [
        color,
        color,
      ]);
}

Widget telegram({required String url}) {
  return wrapperIcon(
      icon: const Icon(
        FontAwesome.telegram,
        color: Color(0xFF0088CC),
        size: 45,
      ),
      url: 'tg://resolve?domain=$url',
      colors: const [
        Colors.white,
        Colors.white,
      ]);
}

Widget tiktok({required String url}) {
  return wrapperIcon(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          'assets/images/tiktok.svg',
        ),
      ),
      url: url,
      colors: const [
        Colors.black,
        Colors.black,
      ]);
}

List<Widget> stars({required int amount}) {
  List<Widget> widgets = [];
  for (int i = 1; i <= 5; i++) {
    widgets.add(const Icon(
      FontAwesome.star,
      color: Colors.yellow,
    ));
  }
  return widgets;
}

List<Widget> medias(List<String> phones, List socialMedia) {
  return phones.map<Widget>((number) => phone(url: number)).toList() +
      socialMedia.map<Widget>(
        (media) {
          switch (media.type) {
            case "Инстаграм":
              return instragram(url: media.url);
            case "Телеграм":
              return telegram(url: media.url);
            case "Тикток":
              return tiktok(url: media.url);
            case "Ютуб":
              return youtube(url: media.url);
            case "Ватсап":
              return whatsapp(url: media.url);
            case "Фейсбук":
              return facebook(url: media.url);
            default:
              return unknown(url: media.url);
          }
        },
      ).toList();
}
