import 'package:besmart_traveler/forms/validators/empty.dart';

import '../components/input.dart';

class UserForm {
  final username = Controller();
  final password = Controller();
  bool passwordIsObscure = true;

  Map<String, String> toJson() {
    return {
      'username': username.text,
      'password': password.text,
    };
  }

  String? validateUsername(String? value) {
    return validateEmpty(value, 'Напишите никнейм');
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return 'Напишите пароль';
    } else if (value.length < 8) {
      return 'Длина пароля должна быть больше 8 символов';
    }

    return null;
  }
}
