import 'input.dart';

List multiSelect({
  required List options,
  required Controller controller,
  required List selected,
}) {
  List optionsSearch = options
      .where((option) =>
          !selected.contains(option.id.toString()) &&
          (controller.text == "" ||
              option.name
                  .toLowerCase()
                  .contains(controller.text.toLowerCase())))
      .take(10)
      .toList();

  List optionsSelected = options
      .where((option) => selected.contains(option.id.toString()))
      .toList();

  return optionsSearch + optionsSelected;
}
