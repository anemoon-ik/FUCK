import 'package:besmart_traveler/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/forms/client.dart';
import 'package:besmart_traveler/forms/user_details.dart';
import 'package:redux/redux.dart';

import '../../../api_service/services/client_service.dart';
import '../../../components/alert.dart';
import '../../../components/button.dart';
import '../../../components/container.dart';
import '../../../components/divider.dart';
import '../../../components/text.dart';
import '../../../components/input.dart';
import '../../../forms/validators/empty.dart';
import '../../../redux/actions/auth.dart';
import '../../../redux/app_state.dart';
import '../../../router/urls.dart';

class VerifyNumberPage extends StatefulWidget {
  const VerifyNumberPage({super.key});

  @override
  State<VerifyNumberPage> createState() => _VerifyNumberPageState();
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  final _formKey = GlobalKey<FormState>();

  String error = '';

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    ClientForm clientForm = store.state.clientForm;
    UserDetailsForm userForm = store.state.userDetailsForm;

    void submit(Store store, BuildContext context) {
      if (_formKey.currentState!.validate()) {
        Map data = {
          'username': userForm.userForm.username.text,
          'password': userForm.userForm.password.text,
          'phone_number': clientForm.phoneNumber.text
        };

        ApiClient.registerPhone(data).then((value) {
          if (value['status'] == 'OK') {
            context.pushNamed(verifyCodePage);
          } else {
            setState(() {
              error = "Попробуйте позже";
            });
          }
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: WillPopScope(
          onWillPop: () async {
            store.dispatch(Logout());
            context.push(authPage);
            return false;
          },
          child: Form(
            key: _formKey,
            child: bodyContainer(
              children: [
                containerB15(child: heading2C('Давайте познакомимся')),
                containerB15(
                    child: heading4('Изменить контактные данные можно будет '
                        'после регистрации в личном кабинете')),
                telegramAlert('Для регистрации вам понадобиться Телеграм'),
                error.isEmpty ? Container() : alertDanger('Попробуйте позже'),
                Center(child: heading4B('Потверждения аккаунта')),
                myDivider(),
                containerB10(
                  child:
                      heading6('Номер телефона в международном формате: +996'),
                ),
                input(
                  controller: clientForm.phoneNumber,
                  text: 'Телефон',
                  validator: (value) {
                    if (value == "") {
                      return 'Напишите телефон';
                    }
                    if (value == "+") {
                      return 'Допишите номер телефона';
                    }
                    if (!RegExp(r'^\+?[1-9]\d{0,14}$').hasMatch(value)) {
                      return 'Номер не может содержать буквы, символы, пробелы';
                    }
                    if (value is String && !value.startsWith("+")) {
                      return 'Напишите в международном формате';
                    }
                    if (!validatePhoneNumber(value)) {
                      return 'Не правильно указан номер телефона';
                    }
                    return null;
                  },
                ),
                button(
                  context: context,
                  text: 'Продолжить',
                  onPressed: () => submit(store, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
