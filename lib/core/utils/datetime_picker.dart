import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as p;
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';

class DatTimePicker {
  static Future<DateTime?> show(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) => _ReminderOptionsModal(),
    );
    if (result.runtimeType == bool) {
      final style = Theme.of(context).textTheme;
      final now = DateTime.now().add(const Duration(minutes: 1));
      return await p.DatePicker.showDateTimePicker(
        context,
        theme: p.DatePickerTheme(
          backgroundColor: AppColors.background,
          itemStyle: style.bodyLarge!,
          doneStyle: style.bodyLarge!,
          cancelStyle: style.bodyLarge!,
        ),
        locale: _getLocaleType(context),
        minTime: now,
        maxTime: DateTime(2100),
        currentTime: now,
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

class _ReminderOptionsModal extends StatefulWidget {
  @override
  State<_ReminderOptionsModal> createState() => _ReminderOptionsModalState();
}

class _ReminderOptionsModalState extends State<_ReminderOptionsModal> {
  late DateTime now;
  late DateTime tomorrowMorning;
  late DateTime tomorrowEvening;
  late DateTime monday;

  @override
  void initState() {
    now = DateTime.now();
    tomorrowMorning = DateTime(now.year, now.month, now.day + 1, 8);
    tomorrowEvening = DateTime(now.year, now.month, now.day + 1, 18);
    int daysToAdd = (DateTime.monday - now.weekday) % 7;
    if (daysToAdd == 0) {
      daysToAdd = 7;
    }
    final nextMonday = now.add(Duration(days: daysToAdd));
    monday = DateTime(
      nextMonday.year,
      nextMonday.month,
      nextMonday.day,
      8,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final tomorrowDay = S.common.labels.shortDays[tomorrowMorning.weekday - 1];

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () => Navigator.pop(context, tomorrowMorning),
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: Text(S.common.utils.dateTimePicker.option1),
            trailing: Text(
              '$tomorrowDay 8:00 AM',
              style: style.bodyLarge,
            ),
          ),
          ListTile(
            onTap: () => Navigator.pop(context, tomorrowEvening),
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: Text(S.common.utils.dateTimePicker.option2),
            trailing: Text('$tomorrowDay 6:00 PM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () => Navigator.pop(context, monday),
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: Text(S.common.utils.dateTimePicker.option3),
            trailing: Text('Mon 8:00 AM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () => Navigator.pop(context, true),
            shape: const RoundedRectangleBorder(),
            leading: const Icon(BoxIcons.bx_time),
            title: Text(S.common.utils.dateTimePicker.option4),
          ),
        ],
      ),
    );
  }
}
