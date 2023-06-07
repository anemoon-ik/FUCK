import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'capitalize.dart';

String showDateWithDay(String leavingDate, String arrivalDate) {
  initializeDateFormatting('ru_RU', null);

  String leavingDay = DateFormat('EEEE', 'ru_RU')
      .format(DateFormat('dd.MM.yyyy').parse(leavingDate));

  String arrivalDay = DateFormat('EEEE', 'ru_RU')
      .format(DateFormat('dd.MM.yyyy').parse(arrivalDate));

  return leavingDate == arrivalDate
      ? " ${capitalize(leavingDay)}, ${leavingDate.substring(0, 5)}"
      : "${capitalize(leavingDay)} ${leavingDate.substring(0, 5)} -  ${capitalize(arrivalDay)} ${arrivalDate.substring(0, 5)}";
}

String showDate(String leavingDate, String arrivalDate) {
  return leavingDate == arrivalDate
      ? leavingDate.substring(0, 5)
      : "${leavingDate.substring(0, 5)} - ${arrivalDate.substring(0, 5)}";
}
