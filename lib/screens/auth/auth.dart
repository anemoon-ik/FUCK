import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_bar.dart';
import '../../components/button.dart';
import '../../components/container.dart';
import '../../components/text.dart';
import '../../constants.dart';
import '../../router/urls.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: appName),
      body: bodyContainer(
        children: [
          containerB15(
            child: heading2C(
              'Быстрее регистрируйся и начни планировать путешествие!',
            ),
          ),
          containerB25(
            child: heading4(
              'Продолжая, вы соглашаетесь на условия использования',
            ),
          ),
          button(
            context: context,
            text: 'Зарегистрироваться',
            onPressed: () {
              context.pushNamed(registerUserPage);
            },
          ),
          button(
            context: context,
            text: 'Войти',
            onPressed: () => context.pushNamed(loginPage),
          ),
        ],
      ),
    );
  }
}
