import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:go_router/go_router.dart';
import 'package:besmart_traveler/api_service/services/user_service.dart';
import 'package:besmart_traveler/components/app_bar.dart';
import 'package:besmart_traveler/components/bottom_app_bar.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:besmart_traveler/router/urls.dart';
import 'package:redux/redux.dart';

import '../../../components/button.dart';
import '../../../components/container.dart';
import '../../../components/input.dart';
import '../../../forms/user_details.dart';
import '../../../models/user/User.dart';
import '../../../redux/app_state.dart';
import '../../../forms/validators/empty.dart';

class AccountUserDetailPage extends StatefulWidget {
  const AccountUserDetailPage({super.key});

  @override
  State<AccountUserDetailPage> createState() => _AccountUserDetailPageState();
}

class _AccountUserDetailPageState extends State<AccountUserDetailPage> {
  bool informationRetrieved = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Store store = StoreProvider.of<AppState>(context);
    UserDetailsForm form = store.state.userDetailsForm;
    User user = store.state.user;

    void submit(Store store, BuildContext context) {
      if (formKey.currentState!.validate()) {
        ApiUser.change(form.toJson(), store.state.token).then((response) {
          user.firstName = response['first_name'];
          user.lastName = response['last_name'];
          context.pushNamed(accountPage);
        });
      }
    }

    return Scaffold(
      appBar: appBar(context: context),
      bottomNavigationBar:
          bottomAppBar(context: context, currentPage: accountPage),
      body: Form(
        key: formKey,
        child: bodyContainer(
          children: [
            containerB20(
              child: heading2('Личная информация'),
            ),
            containerB10(
              child: heading6('Ваше имя'),
            ),
            input(
              controller: form.firstName,
              text: 'Имя',
              onChanged: (value) => validateEmpty(value, 'Напишите имя'),
            ),
            containerB10(child: heading6('Ваше фамилия')),
            input(
              controller: form.lastName,
              text: 'Фамилия',
              onChanged: (value) => validateEmpty(value, 'Напишите фамилию'),
            ),
            button(
              context: context,
              text: 'Изменить',
              onPressed: () => submit(store, context),
            ),
          ],
        ),
      ),
    );
  }
}
