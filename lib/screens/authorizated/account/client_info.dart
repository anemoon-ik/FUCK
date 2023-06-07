import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:besmart_traveler/forms/client.dart';
import 'package:besmart_traveler/forms/select_options.dart';
import 'package:redux/redux.dart';

import '../../../components/app_bar.dart';
import '../../../components/button.dart';
import '../../../components/container.dart';
import '../../../components/text.dart';
import '../../../components/input.dart';
import '../../../forms/validators/empty.dart';
import '../../../redux/app_state.dart';

class AccountClientPage extends StatefulWidget {
  const AccountClientPage({super.key});

  @override
  State<AccountClientPage> createState() => _AccountClientPageState();
}

class _AccountClientPageState extends State<AccountClientPage> {
  final _formKey = GlobalKey<FormState>();

  dynamic errors = {};

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    ClientForm form = store.state.clientForm;
    List workStatus = store.state.workStatus.results;
    List familyStatus = store.state.familyStatus.results;

    void submit(Store store, BuildContext context) {
      if (_formKey.currentState!.validate()) {}
    }

    return Scaffold(
      appBar: appBar(context: context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: bodyContainer(children: [
            containerB20(child: heading2('Дополнительная информация')),
            dateField(
                text: 'Дата рождения',
                controller: form.dateOfBirth,
                validator: (value) =>
                    validateEmpty(value, 'Укажите дату рождения'),
                enabled: false),
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
          ]),
        ),
      ),
    );
  }
}
