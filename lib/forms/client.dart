import '../components/input.dart';

class ClientForm {
  final dateOfBirth = Controller();
  final phoneNumber = Controller();

  String gender = 'male';
  late String workStatus;
  late String familyStatus;
  bool hasChildren = false;

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber.text,
      'date_of_birth': dateOfBirth.text,
      'gender': gender,
      'work_status': workStatus,
      'family_status': familyStatus,
      'has_children': hasChildren.toString(),
    };
  }

  String? validateDateOfBirth(DateTime? value) {
    if (value is! DateTime) {
      return 'Укажите дату рождения';
    }

    DateTime currentDate = DateTime.now();
    num age = currentDate.year - value.year;

    if (age < 12) {
      return 'Приложение можно использовать с 12 лет';
    }

    return null;
  }
}
