import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as p;

import '../../config/config.dart';
import '../../generated/l10n.dart';

Future<DateTime?> showDateTimePicker({
  DateTime? minTime,
  DateTime? currentTime,
}) async {
  BuildContext context = navigatorKey.currentContext!;

  final style = Theme.of(context).textTheme;
  final language = S.of(context).language;
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  late p.LocaleType localeType = p.LocaleType.en;
  if (language == 'es') {
    localeType = p.LocaleType.es;
  }

  return await p.DatePicker.showDatePicker(
    context,
    theme: p.DatePickerTheme(
      backgroundColor: isDarkMode ? MyColors.cardDark : MyColors.cardLight,
      cancelStyle: style.bodyLarge!,
      doneStyle: style.bodyLarge!,
      itemStyle: style.bodyLarge!.copyWith(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    ),
    minTime: minTime,
    currentTime: currentTime,
    locale: localeType,
    onConfirm: (date) => date,
  );
}
