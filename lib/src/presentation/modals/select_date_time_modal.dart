import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../../app.dart';
import '../providers/notifications_provider.dart';

class SelectDateTimeModal extends ConsumerStatefulWidget {
  const SelectDateTimeModal({this.initialDueDate, super.key});

  final DueDate? initialDueDate;

  @override
  ConsumerState<SelectDateTimeModal> createState() =>
      _SelectDateTimeModalState();
}

class _SelectDateTimeModalState extends ConsumerState<SelectDateTimeModal> {
  bool isDateSelected = false;
  bool isTimeSelected = false;
  final now = DateTime.now();
  DateTime? selectedDate;
  DateTime? selectedTime;

  @override
  void initState() {
    if (widget.initialDueDate != null) {
      isDateSelected = true;
      selectedDate = widget.initialDueDate!.date;
      isTimeSelected = widget.initialDueDate!.isReminder;
      selectedTime = widget.initialDueDate!.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final isGrantedNotification =
        ref.watch(notificationsProvider).isGrantedNotification;

    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding / 2,
            ),
            title: Row(
              children: [
                if (isDateSelected)
                  Text(
                    DateFormat('E, d MMM y').format(selectedDate!).toString(),
                    style: style.bodyMedium?.copyWith(color: Colors.white),
                  )
                else
                  Text(
                    S.of(context).button_add_due_date,
                    style: style.bodyMedium?.copyWith(color: Colors.white),
                  ),
                if (isTimeSelected) ...[
                  Text(
                    ', ${DateFormat('jm').format(selectedTime!)}',
                    style: style.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  const Gap(defaultPadding / 2),
                  Icon(BoxIcons.bx_bell, size: 14, color: colors.primary),
                ],
                const Spacer(),
                TextButton(
                  onPressed: isDateSelected
                      ? () {
                          final dueDate = DueDate(
                            date: DateTime(
                              selectedDate!.year,
                              selectedDate!.month,
                              selectedDate!.day,
                              selectedTime?.hour ?? 23,
                              selectedTime?.minute ?? 59,
                            ),
                            isReminder: isTimeSelected,
                          );
                          Navigator.pop(context, dueDate);
                        }
                      : null,
                  child: Text(S.of(context).button_save),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(BoxIcons.bx_calendar, color: colors.primary),
                  title: Text(S.of(context).label_date),
                  trailing: Switch(
                    value: isDateSelected,
                    onChanged: (value) => setState(() {
                      isDateSelected = value;
                      if (value) {
                        selectedDate = now;
                      } else {
                        selectedDate = null;
                        selectedTime = null;
                        isTimeSelected = false;
                      }
                    }),
                  ),
                ),
                if (isDateSelected)
                  CalendarDatePicker2(
                    config: CalendarDatePicker2Config(),
                    value: [selectedDate],
                    onValueChanged: (dates) => setState(() {
                      selectedDate = dates.first;
                    }),
                  )
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(BoxIcons.bx_time, color: colors.primary),
                  title: Text(S.of(context).label_time),
                  trailing: Switch(
                    value: isTimeSelected,
                    onChanged: (value) {
                      if (!isGrantedNotification) return;
                      setState(() {
                        isTimeSelected = value;
                        if (value) {
                          if (!isDateSelected) {
                            isDateSelected = true;
                            selectedDate = now;
                          }
                          selectedTime = now;
                        } else {
                          selectedTime = null;
                        }
                      });
                    },
                  ),
                ),
                if (isTimeSelected)
                  TimePickerWidget(
                    initialTime: selectedTime != null
                        ? TimeOfDay(
                            hour: selectedTime!.hour,
                            minute: selectedTime!.minute,
                          )
                        : null,
                    onChangeSelected: (time) => setState(() {
                      selectedTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        time.hour,
                        time.minute,
                      );
                    }),
                  ),
              ],
            ),
          ),
          if (!isGrantedNotification)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: DisableNotificationButton(),
            ),
        ],
      ),
    );
  }
}
