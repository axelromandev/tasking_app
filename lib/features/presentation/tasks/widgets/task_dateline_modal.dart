import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as pd;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class TaskDatelineModal extends ConsumerStatefulWidget {
  const TaskDatelineModal({
    required this.value,
    this.onDelete,
    super.key,
  });

  final DateTime? value;
  final VoidCallback? onDelete;

  @override
  ConsumerState<TaskDatelineModal> createState() => _TaskDatelineModalState();
}

class _TaskDatelineModalState extends ConsumerState<TaskDatelineModal> {
  final DateTime now = DateTime.now();
  late DateTime today;
  late DateTime tomorrow;
  late DateTime nextWeek;

  @override
  void initState() {
    today = DateTime(now.year, now.month, now.day, 23, 59);
    tomorrow = today.add(const Duration(days: 1));
    _calculateDaysUntilNextMonday();
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
    nextWeek =
        DateTime(nextMonday.year, nextMonday.month, nextMonday.day, 11, 59);
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
                context.pop(today);
              },
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.calendar),
              title: Text(S.features.tasks.datelineLabels.today),
              trailing: Text(
                S.common.labels.longDays[now.weekday - 1],
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                context.pop(tomorrow);
              },
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.calendar_2),
              title: Text(S.features.tasks.datelineLabels.tomorrow),
              trailing: Text(
                S.common.labels.longDays[(now.weekday) % 7],
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                context.pop(nextWeek);
              },
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.calendar_1),
              title: Text(S.features.tasks.datelineLabels.nextWeek),
              trailing: Text(
                S.common.labels.longDays[nextWeek.weekday - 1],
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                pd.DatePicker.showDatePicker(
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
                    context.pop(dateline);
                  },
                  currentTime: widget.value ?? DateTime.now(),
                  theme: pd.DatePickerTheme(
                    backgroundColor: AppColors.background,
                    itemStyle: style.bodyLarge!,
                    doneStyle: style.bodyLarge!.copyWith(color: colorPrimary),
                    cancelStyle: style.bodyLarge!.copyWith(color: Colors.white),
                  ),
                  locale: switch (S.common.locale) {
                    'en' => pd.LocaleType.en,
                    'es' => pd.LocaleType.es,
                    (_) => pd.LocaleType.en,
                  },
                );
              },
              visualDensity: VisualDensity.compact,
              leading: const Icon(IconsaxOutline.calendar_search),
              title: Text(S.features.tasks.datelineLabels.pickDate),
              trailing: const Icon(IconsaxOutline.arrow_right_3, size: 20),
            ),
            if (widget.onDelete != null && widget.value != null) ...[
              const Divider(),
              ListTile(
                onTap: () {
                  widget.onDelete!();
                  context.pop();
                },
                visualDensity: VisualDensity.compact,
                leading: const Icon(IconsaxOutline.trash),
                title: Text(S.features.tasks.datelineLabels.remove),
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
