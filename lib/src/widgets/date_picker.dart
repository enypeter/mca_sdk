import 'dart:developer';
import 'dart:io';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

void showSelectDatePicker(context, {onSelectDate}) {
  Platform.isAndroid
      ? DatePicker.showDatePicker(context,
          theme: const DatePickerTheme(
              containerHeight: 250,
              backgroundColor: WHITE,
              itemStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              doneStyle: TextStyle(
                  color: PRIMARY, fontWeight: FontWeight.w700, fontSize: 18)),
          minTime: DateTime.now().subtract(const Duration(days: 30)),
          maxTime: DateTime.now(), onChanged: (date) {
          log('change $date');
        },
          onConfirm: onSelectDate,
          currentTime: DateTime.now(),
          locale: LocaleType.en)
      : showCupertinoModalPopup(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: 250,
              color: Colors.white,
              child: CupertinoDatePicker(
                  backgroundColor: WHITE,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now().add(const Duration(days: 10)),
                  minimumDate: DateTime.now().subtract(const Duration(days: 1)),
                  minimumYear: DateTime.now().year,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: onSelectDate),
            );
          });
}
