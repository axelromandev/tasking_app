import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as pd;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskReminderModal extends ConsumerStatefulWidget {
  const TaskReminderModal({
    required this.value,
    required this.onDelete,
    super.key,
  });

  final DateTime? value;
  final VoidCallback onDelete;

  @override
  ConsumerState<TaskReminderModal> createState() => _TaskReminderModalState();
}

class _TaskReminderModalState extends ConsumerState<TaskReminderModal> {
  final DateTime now = DateTime.now();
  late DateTime laterToday;
  late DateTime tomorrow;
  late DateTime nextWeek;

  late bool isEnabledLaterToday;

  @override
  void initState() {
    laterToday = DateTime(now.year, now.month, now.day, 22);
    tomorrow = DateTime(now.year, now.month, now.day + 1, 9);
    _calculateDaysUntilNextMonday();

    isEnabledLaterToday = laterToday.isAfter(now);

    super.initState();
  }

  void _calculateDaysUntilNextMonday() {
    final int daysUntilNextMonday = switch (now.weekday) {
      DateTime.monday => 7,
      DateTime.tuesday => 6,
      DateTime.wednesday => 5,
      DateTime.thursday => 4,
      DateTime.friday => 3,
      DateTime.saturday => 2,
      DateTime.sunday => 1,
      (_) => 0,
    };
    final DateTime nextMonday = now.add(Duration(days: daysUntilNextMonday));
    nextWeek = DateTime(nextMonday.year, nextMonday.month, nextMonday.day, 9);
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context, laterToday);
              },
              enabled: isEnabledLaterToday,
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.clock),
              title: Text(S.features.tasks.reminderLabels.laterToday),
              trailing: isEnabledLaterToday
                  ? Text(
                      DateFormat.jm().format(laterToday),
                      style: const TextStyle(color: Colors.grey),
                    )
                  : null,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context, tomorrow);
              },
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.clock),
              title: Text(S.features.tasks.reminderLabels.tomorrowMorning),
              trailing: Text(
                '${S.common.labels.shortDays[tomorrow.weekday - 1]}, '
                '${DateFormat.jm().format(tomorrow)}',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context, nextWeek);
              },
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.clock),
              title: Text(S.features.tasks.reminderLabels.nextWeek),
              trailing: Text(
                '${S.common.labels.shortDays[nextWeek.weekday - 1]}, '
                '${DateFormat.jm().format(nextWeek)}',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                pd.DatePicker.showDateTimePicker(
                  context,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(const Duration(days: 3650)),
                  onConfirm: (date) {
                    final DateTime dateline = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      23,
                      59,
                    );
                    Navigator.pop(context, dateline);
                  },
                  currentTime: widget.value ?? DateTime.now(),
                  theme: pd.DatePickerTheme(
                    backgroundColor: AppColors.background,
                    itemStyle: style.bodyLarge!,
                    doneStyle: style.bodyLarge!.copyWith(color: colorPrimary),
                    cancelStyle: style.bodyLarge!.copyWith(color: Colors.white),
                    containerHeight: 400,
                  ),
                  locale: switch (S.common.locale) {
                    'en' => pd.LocaleType.en,
                    'es' => pd.LocaleType.es,
                    (_) => pd.LocaleType.en,
                  },
                );
              },
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.clock),
              title: Text(S.features.tasks.reminderLabels.pickDateTime),
              trailing: const Icon(IconsaxOutline.arrow_right_3, size: 20),
            ),
            if (widget.value != null) ...[
              const Divider(),
              ListTile(
                onTap: () {
                  widget.onDelete();
                  Navigator.pop(context);
                },
                visualDensity: VisualDensity.compact,
                leading: const Icon(IconsaxOutline.trash),
                title: Text(S.features.tasks.reminderLabels.remove),
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
              ),
            ],
          ],
        ),
      ),
    );
    // return _DateTimeTextField();
  }
}
