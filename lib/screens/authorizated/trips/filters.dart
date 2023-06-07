import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../../components/button.dart';
import '../../../components/container.dart';
import '../../../components/input.dart';
import '../../../components/text.dart';
import '../../../forms/search_trips.dart';
import '../../../forms/select_options.dart';

SizedBox boxW40({required Widget child, required BuildContext context}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.4,
    child: child,
  );
}

Form filtersForm(
  formKey,
  BuildContext context,
  SearchTripsForm form,
  Function reload,
  List<Widget> levelsWid,
  List<Widget> locationsWid,
  List<Widget> companiesWid,
  Function submit,
  Store store,
) {
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        containerB10(child: heading4B('Цена')),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                boxW40(
                  context: context,
                  child: input(
                    controller: form.minPriceText,
                    text: 'От',
                    validator: form.validateMinPrice,
                    numberKeyBoard: true,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                boxW40(
                  context: context,
                  child: input(
                    controller: form.maxPriceText,
                    text: 'До',
                    validator: form.validateMaxPrice,
                    numberKeyBoard: true,
                  ),
                ),
              ],
            ),
          ],
        ),
        containerB20(child: const Divider()),
        containerB10(child: heading4B('Дата')),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boxW40(
              context: context,
              child: dateField(
                text: 'От',
                controller: form.dateStartCont,
                validator: form.validatedateStart,
                past: false,
              ),
            ),
            boxW40(
              context: context,
              child: dateField(
                text: 'До',
                controller: form.dateEndCont,
                validator: form.validatedateEnd,
                past: false,
              ),
            ),
          ],
        ),
        containerB20(child: const Divider()),
        containerB10(child: heading4B('Время')),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boxW40(
              context: context,
              child: selectField(
                label: 'От',
                selected: form.timeStartCont,
                options: timeOptions,
                validator: form.validateStartTime,
                onChange: (newValue) {
                  form.timeStartCont = newValue;
                },
              ),
            ),
            boxW40(
              context: context,
              child: selectField(
                label: 'До',
                selected: form.timeEndCont,
                options: timeOptions,
                validator: form.validateEndTime,
                onChange: (newValue) {
                  form.timeEndCont = newValue;
                },
              ),
            ),
          ],
        ),
        containerB10(child: const Divider()),
        containerB15(child: heading4B('Выберите уровни сложности')),
        containerB20(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: levelsWid,
          ),
        ),
        containerB10(child: const Divider()),
        containerB15(child: heading4B('Нажмите на нужные локации')),
        input(
          controller: form.searchLocation,
          text: 'Поиск по названию',
          onChanged: reload,
        ),
        containerB20(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: locationsWid,
          ),
        ),
        containerB10(child: const Divider()),
        containerB15(child: heading4B('Нажмите на нужные компании')),
        input(
          controller: form.searchCompany,
          text: 'Поиск по названию',
          onChanged: reload,
        ),
        containerB20(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: companiesWid,
          ),
        ),
        button(
          context: context,
          text: 'Найти',
          onPressed: () => submit(store, form),
        )
      ],
    ),
  );
}
