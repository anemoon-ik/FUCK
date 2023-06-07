import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/api_service/services/user_service.dart';
import 'package:besmart_traveler/forms/client.dart';
import 'package:besmart_traveler/forms/select_options.dart';
import 'package:redux/redux.dart';

import '../../../components/alert.dart';
import '../../../components/app_bar.dart';
import '../../../components/button.dart';
import '../../../components/container.dart';
import '../../../components/divider.dart';
import '../../../components/text.dart';
import '../../../components/input.dart';
import '../../../redux/app_state.dart';
import '../../../router/urls.dart';

class RegisterClientPage extends StatefulWidget {
  const RegisterClientPage({super.key});

  @override
  State<RegisterClientPage> createState() => _RegisterClientPageState();
}

class _RegisterClientPageState extends State<RegisterClientPage> {
  final _formKey = GlobalKey<FormState>();

  dynamic errors = {};

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    ClientForm form = store.state.clientForm;
    List workStatus = store.state.workStatus.results;
    List familyStatus = store.state.familyStatus.results;

    form.workStatus = workStatus[0].name;
    form.familyStatus = familyStatus[0].name;

    void submit(Store store, BuildContext context) {
      if (_formKey.currentState!.validate()) {
        Map<String, dynamic> map1 = form.toJson();

        map1['phone_number'] =
            store.state.userDetailsForm.userForm.username.text;
        map1.addAll(store.state.userDetailsForm.toJson());

        ApiUser.register(map1).then((map2) {
          if (map1['username'] == map2['username']) {
            context.pushNamed(verifyNumPage);
          } else {
            setState(() {
              errors = map2;
            });
          }
        });
      }
    }

    return Scaffold(
      appBar: appBar(context: context, title: 'Регистрация'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: bodyContainer(
            children: [
              containerB10(child: heading2C('Давайте познакомимся')),
              containerB20(child: heading3('Заполните данные')),
              telegramAlert('Для регистрации вам понадобиться Телеграм'),
              Center(child: heading4B('Данные для рекомендаций')),
              containerB20(child: myDivider()),
              errors.isEmpty
                  ? Container()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: errors.entries
                          .map((entry) {
                            return containerB20(
                              child: redText('${entry.key}: ${entry.value[0]}'),
                            );
                          })
                          .toList()
                          .cast<Widget>(),
                    ),
              containerB15(child: heading4B('Ваша дата рождения')),
              dateField(
                text: 'Дата рождения',
                controller: form.dateOfBirth,
                validator: form.validateDateOfBirth,
              ),
              selectField(
                label: 'Ваш пол',
                selected: form.gender,
                options: genderOptions,
                onChange: (value) => form.gender = value,
              ),
              selectField(
                label: 'Ваш рабочий статус',
                selected: form.workStatus,
                options: workStatus.map((e) => [e.name, e.name]).toList(),
                onChange: (value) => form.workStatus = value,
              ),
              selectField(
                label: 'Ваш семейный статус',
                selected: form.familyStatus,
                options: familyStatus.map((e) => [e.name, e.name]).toList(),
                onChange: (value) => form.familyStatus = value,
              ),
              checkbox(
                isChecked: form.hasChildren,
                text: 'Имеются дети',
                labelToggle: (b) =>
                    setState(() => form.hasChildren = !form.hasChildren),
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
    );
  }
}
