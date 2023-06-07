import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/api_service/services/user_service.dart';
import 'package:redux/redux.dart';

import '../../../components/alert.dart';
import '../../../components/app_bar.dart';
import '../../../components/button.dart';
import '../../../components/container.dart';
import '../../../components/divider.dart';
import '../../../components/policy.dart';
import '../../../components/text.dart';
import '../../../components/input.dart';
import '../../../forms/user_details.dart';
import '../../../utils/capitalize.dart';
import '../../../redux/app_state.dart';
import '../../../router/urls.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final formKey = GlobalKey<FormState>();

  dynamic errors = {};

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    UserDetailsForm form = store.state.userDetailsForm;

    Widget showErrors(errors) {
      if (errors.isEmpty) {
        return Container();
      }

      return Column(
        children: errors.entries
            .map((entry) {
              return containerB20(
                child: redText(entry.value[0]),
              );
            })
            .toList()
            .cast<Widget>(),
      );
    }

    void submit(Store store, BuildContext context) {
      if (formKey.currentState!.validate()) {
        Map<String, dynamic> map1 = form.toJson();

        ApiUser.test(map1).then((map2) {
          if (map1['username'] == map2['username']) {
            context.pushNamed(registerClientPage);
          } else {
            setState(() => errors = map2);
          }
        });
      }
    }

    return Scaffold(
      appBar: appBar(context: context, title: 'Регистрация'),
      body: Form(
        key: formKey,
        child: bodyContainer(
          children: [
            containerB10(child: heading2C('Давайте познакомимся')),
            containerB20(child: heading3('Заполните данные')),
            telegramAlert('Для регистрации вам понадобиться Телеграм'),
            Center(child: heading4B('Личные данные')),
            myDivider(),
            showErrors(errors),
            input(
              controller: form.firstName,
              text: 'Имя',
              validator: form.validateFirstName,
              onChanged: (v) => {
                form.firstName.value = form.firstName.value.copyWith(
                  text: capitalize(v),
                  selection: TextSelection.collapsed(offset: v.length),
                )
              },
            ),
            input(
              controller: form.lastName,
              text: 'Фамилия',
              validator: form.validateLastName,
              onChanged: (v) => {
                form.lastName.value = form.lastName.value.copyWith(
                  text: capitalize(v),
                  selection: TextSelection.collapsed(offset: v.length),
                )
              },
            ),
            input(
              controller: form.userForm.username,
              text: 'Никнейм',
              validator: form.userForm.validateUsername,
            ),
            passwordInput(
              obscure: form.passwordIsObscure,
              controller: form.userForm.password,
              text: 'Ваш пароль',
              toggle: () => setState(() {
                form.passwordIsObscure = !form.passwordIsObscure;
              }),
              validator: form.userForm.validatePassword,
            ),
            passwordInput(
              obscure: form.passwordRepeatIsObscure,
              controller: form.passwordRepeat,
              text: 'Повторите пароль',
              toggle: () => setState(() {
                form.passwordRepeatIsObscure = !form.passwordRepeatIsObscure;
              }),
              validator: form.validatePasswordRepeat,
            ),
            policyBlock(context),
            button(
              context: context,
              text: 'Продолжить',
              onPressed: () => submit(store, context),
            ),
          ],
        ),
      ),
    );
  }
}
