  import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redux/redux.dart';

import '../api_service/services/user_service.dart';
import '../api_service/services/client_service.dart';
import '../models/user/token.dart';
import '../redux/actions/auth.dart';
import '../router/urls.dart';
import 'get_info.dart';

void processLogin(BuildContext context, dynamic value, Store store, Function error) {
    if (value is Token) {
      store.dispatch(SetToken(token: value));

      ApiClient.getClientInfo(value).then((client) {
        store.dispatch(SetClient(client: client));
      });

      ApiUser.getUserInfo(value).then((user) {
        store.dispatch(SetUser(user: user));
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        getInfo(store, value);

        context.pushNamed(homePage);
      });
    }
    if (value is String) {
      error(value);
    }
  }