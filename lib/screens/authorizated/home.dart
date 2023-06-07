import 'package:besmart_traveler/router/urls.dart';
import 'package:flutter/material.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';

import '../../components/container.dart';
import '../../components/text.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomAppBar(
        context: context,
        currentPage: homePage,
      ),
      body: bodyContainer(
        children: [
          const SizedBox(height: 10),
          containerB20(child: heading1(appName)),
          containerB10(
            child: heading4(
              '   Добро пожаловать на наш туристическую платформу, которая является '
              'идеальным решением для путешественников, желающих узнать о различных '
              'турах внутри нашей страны. Мобильное приложение является надежным и '
              'точным источником информации, которое содержит все необходимые данные '
              'о туристических направлениях и предоставляет их на одном удобном месте.',
            ),
          ),
          containerB20(
            child: heading4(
              '   Мы стремимся обеспечить максимальную удобность и комфорт нашим '
              'пользователям, предоставляя подробную информацию о популярных '
              'туристических местах. Наша команда профессионалов работает над тем, '
              'чтобы каждый пользователь нашего сайта получал только самую '
              'актуальную и полезную информацию, которая поможет ему спланировать '
              'свое путешествие с учетом всех особенностей и пожеланий.',
            ),
          ),
        ],
      ),
    );
  }
}
