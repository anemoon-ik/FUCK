import 'package:intl/intl.dart';

import '../components/input.dart';

class SearchTripsForm {
  final minPriceText = Controller();
  final maxPriceText = Controller();
  final dateStartCont = Controller();
  final dateEndCont = Controller();
  final searchLocation = Controller();
  final searchCompany = Controller();

  List<String> selectedLevels = [];
  List<String> selectedLocations = [];
  List<String> selectedCompanies = [];

  DateFormat dateFormat = DateFormat('dd.MM.yyyy');

  String timeStartCont = '00:00';
  String timeEndCont = '23:00';

  Map<String, dynamic> toJson() {
    return {
      "min_price": minPriceText.text,
      "max_price": maxPriceText.text,
      "date_start": dateStartCont.text,
      "date_end": dateEndCont.text,
      "levels": selectedLevels,
      "locations": selectedLocations,
    };
  }

  String? validateMinPrice(v) {
    double? minPrice = double.tryParse(minPriceText.text);
    double? maxPrice = double.tryParse(maxPriceText.text);

    if (minPriceText.text.isNotEmpty && minPrice == null) {
      return 'Не верное значение';
    } else if (minPrice != null && minPrice < 0) {
      return "Цена не может быть\nотрицательной";
    } else if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
      return ('Минимальная цена\nне может быть больше\nмаксимальной цены');
    }

    return null;
  }

  String? validateMaxPrice(v) {
    double? minPrice = double.tryParse(minPriceText.text);
    double? maxPrice = double.tryParse(maxPriceText.text);

    if (maxPriceText.text.isNotEmpty && maxPrice == null) {
      return 'Не верное значение';
    } else if (maxPrice != null && maxPrice < 0) {
      return "Цена не может быть\nотрицательной";
    } else if (minPrice != null && maxPrice != null && minPrice > maxPrice) {
      return 'Максимальная цена\nне может быть больше\nминамальной цены';
    }

    return null;
  }

  String? validatedateStart(v) {
    if (dateStartCont.text.length > 1 && dateEndCont.text.length > 1) {
      DateTime dateTime1 = dateFormat.parse(dateStartCont.text);
      DateTime dateTime2 = dateFormat.parse(dateEndCont.text);

      if (dateTime2.isBefore(dateTime1)) {
        return ('Дата отъезда\nдолжна быть раньше\nдаты приезда ');
      }
    }
    return null;
  }

  String? validatedateEnd(v) {
    if (dateStartCont.text.length > 1 && dateEndCont.text.length > 1) {
      DateTime dateTime1 = dateFormat.parse(dateStartCont.text);
      DateTime dateTime2 = dateFormat.parse(dateEndCont.text);

      if (dateTime2.isBefore(dateTime1)) {
        return ('Дата приезда\nдолжна быть позже\nдаты отъезда');
      }
    }

    return null;
  }

  String? validateStartTime(v) {
    if (dateStartCont.text.length > 1 &&
        dateEndCont.text.length > 1 &&
        dateStartCont.text == dateEndCont.text) {
      
      double timeStart = double.parse(timeStartCont.substring(0, 2));
      double timeEnd = double.parse(timeEndCont.substring(0, 2));

      if (timeStart > timeEnd) {
        return 'Время отбытия\nне может быть больше\nвремя прибытия ';
      }
    }

    return null;
  }

  String? validateEndTime(v) {
    if (dateStartCont.text.length > 1 &&
        dateEndCont.text.length > 1 &&
        dateStartCont.text == dateEndCont.text) {
      
      double timeStart = double.parse(timeStartCont.substring(0, 2));
      double timeEnd = double.parse(timeEndCont.substring(0, 2));

      if (timeStart > timeEnd) {
        return 'Время прибытия\nне может быть меньше\nвремя отбытия ';
      }
    }

    return null;
  }
}
