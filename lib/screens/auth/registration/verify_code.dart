import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:besmart_traveler/forms/user_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:redux/redux.dart';

import '../../../api_service/services/user_service.dart';
import '../../../api_service/services/client_service.dart';
import '../../../components/alert.dart';
import '../../../components/app_bar.dart';
import '../../../components/button.dart';
import '../../../components/container.dart';
import '../../../components/divider.dart';
import '../../../components/text.dart';
import '../../../components/input.dart';
import '../../../utils/proccess_login.dart';
import '../../../forms/validators/empty.dart';
import '../../../redux/app_state.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _formKey = GlobalKey<FormState>();
  final codeContr = Controller();

  String error = '';

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    void submit(Store store, BuildContext context) {
      if (_formKey.currentState!.validate()) {
        UserDetailsForm form = store.state.userDetailsForm;
        Map data = {
          'activation_code': codeContr.value.text,
          'username': form.userForm.username.text,
        };

        ApiClient.verifyPhone(data).then((value) {
          if (value['status'] == 'Wrong code') {
            setState(() {
              error = 'Зайдите в телеграмм вы ссылке выше, '
                  'напишете боту, вам будет отправлен новый код';
            });
          } else if (value['status'] == 'Activated') {
            ApiUser.login(form.toJson()).then(
                (value) => processLogin(context, value, store, (error) {}));
          }
        });
      }
    }

    return Scaffold(
      appBar: appBar(context: context, title: 'Регистрация'),
      body: Form(
        key: _formKey,
        child: bodyContainer(
          children: [
            containerB10(child: heading2C('Давайте познакомимся')),
            containerB20(child: heading3('Заполните данные')),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("tg://resolve?domain=TravelKgAppBot"));
              },
              child: telegramAlert(
                'Перейти к telegram боту для подтверждения  номера телефона',
              ),
            ),
            error.isEmpty ? Container() : alertDanger(error),
            Center(child: heading4B('Потверждения аккаунта')),
            myDivider(),
            input(
              controller: codeContr,
              text: 'Код',
              validator: (value) => validateEmpty(value, 'Напишите код'),
            ),
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
