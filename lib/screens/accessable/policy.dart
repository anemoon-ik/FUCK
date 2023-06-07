import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/components/button.dart';
import 'package:besmart_traveler/components/container.dart';
import 'package:besmart_traveler/router/urls.dart';

import '../../components/app_bar.dart';
import '../../components/text.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: bodyContainer(
        children: [
          // TODO: list of all texts
          containerB20(child: heading2('Политика Конфидициальности')),
          containerB10(child: heading4B('Сбор информации.')),
          containerB10(child: heading4('''
    При использовании приложения "Travel.kg" мы можем собирать следующие данные:
      - Имя
      - Фамилия
      - Адрес электронной почты
      - Номер телефона 
      - Другие контактные данные;
      - Данные о местоположении;
      - Данные о путешествиях и предпочтениях;
      - Информацию, связанную с использованием приложения, включая время проведения в приложении и IP-адрес.''')),
          containerB10(child: heading4B('Использование информации.')),
          containerB15(
              child: heading4(
                  '   Собранные данные используются для предоставления персонализированных рекомендаций и таргетированной рекламы. Мы можем также использовать данные для улучшения функциональности приложения и анализа использования приложения.')),
          containerB10(child: heading4B('Передача данных третьим лицам.')),
          containerB15(
              child: heading4(
                  '   Мы можем передавать данные третьим лицам, включая наших партнеров по рекламе, аналитиков и других лиц, которые помогают нам предоставлять услуги.')),
          containerB10(child: heading4B('Хранение данных.')),
          containerB15(
              child: heading4(
                  '   Мы храним данные до тех пор, пока вы не удалите свой аккаунт. После удаления аккаунта мы удаляем все собранные данные.')),
          containerB10(child: heading4B('Управление данными.')),
          containerB10(
              child: heading4(
                  '   В будущем вы сможете удалить свой аккаунт в любое время в настройках профиля, а на данный момент свяжитесь с тех поддержкой для удаления. Личные данные отображаются в профиле, и другие пользователи могут просматривать данные.')),
          containerB10(
              child: heading4(
                  '   Мы предпринимаем все необходимые меры для защиты ваших персональных данных, включая аутентификацию и идентификацию при входе в систему, контроль допуска к информации для пользователей разных уровней и шифрование данных. Мы также защищаем ваш номер телефона от несанкционированного доступа.')),
          containerB10(
              child: heading4(
                  '   Мы ценим вашу конфиденциальность и делаем все возможное, чтобы защитить ваши данные.')),
          containerB20(
              child: heading4(
                  '   Если у вас есть вопросы или комментарии по поводу нашей политики конфиденциальности, пожалуйста, свяжитесь с нами через нашу службу поддержки.')),
          button(
            context: context,
            text: 'Тех поддержка',
            onPressed: () => context.pushNamed(helpPage),
          )
        ],
      ),
    );
  }
}
