import 'package:flutter/material.dart';
import 'package:besmart_traveler/components/text.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'container.dart';

class Controller extends TextEditingController {}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: borderRadius,
  borderSide: const BorderSide(
    color: Colors.brown,
  ),
);

Container input({
  required Controller controller,
  required String text,
  dynamic validator,
  dynamic onChanged,
  bool numberKeyBoard = false,
}) {
  return containerB20(
    child: TextFormField(
      keyboardType: numberKeyBoard ? TextInputType.number : TextInputType.text,
      controller: controller,
      validator: (value) {
        if (validator != null) {
          return validator(value);
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: text,
        border: outlineInputBorder,
      ),
      onChanged: onChanged,
      onTapOutside: (event) {
        controller.text = controller.text.trimRight();
      },
    ),
  );
}

Container passwordInput({
  required bool obscure,
  required Controller controller,
  required String text,
  required dynamic toggle,
  required dynamic validator,
}) {
  return containerB20(
    child: TextFormField(
      obscureText: obscure,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: text,
        border: outlineInputBorder,
        suffixIcon: IconButton(
          onPressed: toggle,
          icon: Icon(
            obscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
      onTapOutside: (event) {
        controller.text = controller.text.trimRight();
      },
    ),
  );
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return color;
  }
  return colorDark;
}

Container checkbox({
  required bool isChecked,
  required String text,
  required dynamic labelToggle,
}) {
  return containerB20(
    child: Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: labelToggle),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: heading5(text),
        ),
      ],
    ),
  );
}

Container selectField({
  required String label,
  required dynamic selected,
  required List<List> options,
  dynamic onChange,
  validator,
}) {
  var optionsWidgets = options.map((option) => DropdownMenuItem(
        value: option[0],
        child: heading4(option[1]),
      ));

  return containerB20(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        containerB15(child: heading4B(label)),
        DropdownButtonFormField(
          validator: validator,
          borderRadius: borderRadius,
          value: selected,
          elevation: 12,
          isExpanded: true,
          decoration: InputDecoration(
            border: outlineInputBorder,
          ),
          items: optionsWidgets.toList(),
          onChanged: (value) {
            onChange(value);
          },
        ),
      ],
    ),
  );
}

Container dateField({
  required String text,
  required Controller controller,
  required dynamic validator,
  bool past = true,
  bool enabled = true,
}) {
  return containerB20(
    child: DateTimeField(
      enabled: enabled,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      format: DateFormat('dd.MM.yyyy'),
      decoration: InputDecoration(
        labelText: text,
        border: outlineInputBorder,
      ),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          helpText: text,
          cancelText: 'Отменить',
          confirmText: 'Подвердить',
          context: context,
          firstDate: (past == true) ? DateTime(1950) : DateTime.now(),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: (past == true)
              ? DateTime.now()
              : DateTime(DateTime.now().year + 1),
        );
      },
    ),
  );
}
