import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/api_service/services/user_service.dart';
import 'package:besmart_traveler/api_service/errors.dart';
import 'package:besmart_traveler/router/urls.dart';
import 'package:redux/redux.dart';

import '../../components/app_bar.dart';
import '../../components/button.dart';
import '../../components/container.dart';
import '../../components/text.dart';
import '../../components/input.dart';
import '../../forms/user_details.dart';
import '../../utils/proccess_login.dart';
import '../../forms/validators/empty.dart';
import '../../redux/app_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  dynamic response = '';

  Widget isError() {
    Widget error = Container();
    if (response == notFoundError) {
      error = containerB10(child: redText('Пользователь не найден'));
    } else if (response == connectionError) {
      error = containerB10(
        child: redText(
          'Сервес временно не доступен, попробуйте позже',
        ),
      );
    } else if (response == notActivated) {
      error = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          containerB10(
            child: redText(
              'Нужно пройти верификацию',
            ),
          ),
          containerB10(
            child: buttonSm(
              context: context,
              text: 'Пройти',
              onPressed: () {
                context.pushNamed(verifyNumPage);
              },
            ),
          ),
        ],
      );
    }

    return error;
  }

  void authorize(Store store, BuildContext context, UserDetailsForm form) {
    if (_formKey.currentState!.validate()) {
      response = ApiUser.login(form.userForm.toJson()).then(
        (value) => processLogin(
          context,
          value,
          store,
          (error) => setState(() => response = error),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    UserDetailsForm form = store.state.userDetailsForm;

    return Scaffold(
      appBar: appBar(context: context, title: 'Вход в аккаунт'),
      body: Form(
        key: _formKey,
        child: bodyContainer(
          children: [
            containerB10(child: heading2C('Рады вас снова видеть')),
            containerB10(child: heading3('Введите ваши данные ниже')),
            isError(),
            containerB10(),
            input(
              controller: form.userForm.username,
              text: 'Ваш никнейм или номер телефона',
              validator: (value) => validateEmpty(
                value,
                'Напишите ваш никнейм или номер телефона',
              ),
            ),
            passwordInput(
              obscure: form.userForm.passwordIsObscure,
              controller: form.userForm.password,
              text: 'Ваш пароль',
              toggle: () => setState(() {
                form.userForm.passwordIsObscure =
                    !form.userForm.passwordIsObscure;
              }),
              validator: (value) => validateEmpty(value, 'Напишите пароль'),
            ),
            button(
              context: context,
              text: 'Продолжить',
              onPressed: () => authorize(store, context, form),
            ),
          ],
        ),
      ),
    );
  }
}
