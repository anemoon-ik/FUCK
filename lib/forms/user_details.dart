import 'package:besmart_traveler/forms/user.dart';
import 'package:besmart_traveler/forms/validators/empty.dart';

import '../components/input.dart';

class UserDetailsForm {
  final UserForm userForm = UserForm();
  final firstName = Controller();
  final lastName = Controller();
  final passwordRepeat = Controller();

  bool informationRetrieved = false;
  bool passwordIsObscure = true;
  bool passwordRepeatIsObscure = true;

  Map<String, dynamic> toJson() {
    return {
      "username": userForm.username.text,
      "password": userForm.password.text,
      "first_name": firstName.text,
      "last_name": lastName.text,
    };
  }

  String? validateFirstName(String? value) {
    return validateEmpty(value, 'Напишите имя');
  }

  String? validateLastName(String? value) {
    return validateEmpty(value, 'Напишите фамилию');
  }

  String? validatePasswordRepeat(String? value) {
    if (value == "") {
      return "Повторите пароль";
    } else if (value != userForm.password.text) {
      return 'Пароли должны совпадать';
    }

    return null;
  }
}
