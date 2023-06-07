String? validateEmpty(dynamic value, String error) {
  if (value == null || (value is String && value.isEmpty)) {
    return error;
  }

  if (value is String && value.contains(' ')) {
    return 'Поле не должно содержать пробелы';
  }

  return null;
}

bool validatePhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+[1-9]\d{1,14}$');

  return regex.hasMatch(phoneNumber);
}
