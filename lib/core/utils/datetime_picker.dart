import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as p;
import 'package:icons_plus/icons_plus.dart';

import '../../config/const/constants.dart';
import '../../generated/strings.g.dart';

class DatTimePicker {
  static Future<DateTime?> show(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) => _ReminderOptionsModal(),
    );
    if (result.runtimeType == bool) {
      final style = Theme.of(context).textTheme;
      return await p.DatePicker.showDateTimePicker(
        context,
        theme: p.DatePickerTheme(
          backgroundColor: AppColors.background,
          itemStyle: style.bodyLarge!,
          doneStyle: style.bodyLarge!,
          cancelStyle: style.bodyLarge!,
        ),
        locale: _getLocaleType(context),
        minTime: DateTime.now(),
        maxTime: DateTime(2100),
        currentTime: DateTime.now(),
      );
    }
    return result as DateTime?;
  }

  static p.LocaleType _getLocaleType(BuildContext context) {
    final locale = TranslationProvider.of(context).flutterLocale;
    if (locale == const Locale('es')) {
      return p.LocaleType.es;
    }
    return p.LocaleType.en;
  }
}

class _ReminderOptionsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              final now = DateTime.now();
              final date = DateTime(now.year, now.month, now.day + 1, 8);
              Navigator.pop(context, date);
            },
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Tomorrow morning'),
            trailing: Text('8:00 AM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () {
              final now = DateTime.now();
              final date = DateTime(now.year, now.month, now.day + 1, 18);
              Navigator.pop(context, date);
            },
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Tomorrow evening'),
            trailing: Text('6:00 PM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () {
              final now = DateTime.now();
              int daysToAdd = (DateTime.monday - now.weekday) % 7;
              if (daysToAdd == 0) {
                daysToAdd = 7;
              }
              final nextMonday = now.add(Duration(days: daysToAdd));
              final date = DateTime(
                nextMonday.year,
                nextMonday.month,
                nextMonday.day,
                8,
              );
              Navigator.pop(context, date);
            },
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Monday morning'),
            trailing: Text('Mon 8:00 AM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context, true);
            },
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Pick a date & time'),
          ),
        ],
      ),
    );
  }
}
