import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user/User.dart';
import '../../models/user/token.dart';
import '../errors.dart';
import '../methods.dart';
import '../urls.dart';

class ApiUser {
  static Future<User> getUserInfo(Token? token) async {
    var body = await httpGet(
      Urls.baseApiUrl + Urls.userProfile,
      token,
    );

    return User.fromJson(body);
  }

  static Future<dynamic> change(Map values, Token token) async {
    return await httpPut(
      Urls.baseApiUrl + Urls.userProfile,
      values,
      token,
    );
  }

  static Future<Token> refreshToken(String refresh) async {
    var body = await httpPost(
      Urls.baseApiUrl + Urls.refreshToken,
      {"refresh": refresh},
    );

    return Token.setToken(body['refresh'], body['access']);
  }

  static Future<dynamic> login(Map values) async {
    try {
      var url = Uri.parse(Urls.baseApiUrl + Urls.login);
      var response = await http.post(url, body: values);

      if (response.statusCode == 200) {
        dynamic values = json.decode(utf8.decode(response.bodyBytes));

        if (values == notActivated) {
          return notActivated;
        }

        return await Token.setToken(values['refresh'], values['access']);
      }

      return notFoundError;
    } catch (e) {
      return connectionError;
    }
  }

  static Future<dynamic> register(Map<String, dynamic> values) async {
    return await httpPost(
      Urls.baseApiUrl + Urls.register,
      values,
    );
  }

  static Future<dynamic> test(Map values) async {
    return await httpPost(
      Urls.baseApiUrl + Urls.userTest,
      values,
    );
  }
}
