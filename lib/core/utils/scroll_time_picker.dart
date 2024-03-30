import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../config/config.dart';

Future<void> showScrollTimePicker({
  required BuildContext context,
  required Function(TimeOfDay) onSelected,
  TimeOfDay? initialTime,
}) async {
  await showModalBottomSheet<TimeOfDay?>(
    context: context,
    elevation: 0,
    builder: (_) => _TimePicker(
      initialTime: initialTime,
      onSelected: onSelected,
    ),
  );
}

class _TimePicker extends StatefulWidget {
  const _TimePicker({required this.onSelected, this.initialTime});

  final TimeOfDay? initialTime;
  final Function(TimeOfDay) onSelected;

  @override
  State<_TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<_TimePicker> {
  int hour = 8;
  int minute = 0;
  int periodOffset = 0;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _initialize() {
    if (widget.initialTime != null) {
      TimeOfDay initialTime = widget.initialTime!;
      hour = initialTime.hourOfPeriod;
      minute = initialTime.minute;
      periodOffset = initialTime.period.index;
    }
  }

  void _onDone() {
    TimeOfDay? selectedTime;
    if (periodOffset == 0 && hour == 12) {
      selectedTime = TimeOfDay(hour: 0, minute: minute);
    } else if (periodOffset == 1 && hour == 12) {
      selectedTime = TimeOfDay(hour: 12, minute: minute);
    } else {
      selectedTime = TimeOfDay(
        hour: periodOffset == 1 ? hour + 12 : hour,
        minute: minute,
      );
    }
    widget.onSelected.call(selectedTime);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: defaultPadding),
              title: const Text('Select Time'),
              trailing: TextButton(
                onPressed: _onDone,
                child: Text('Done',
                    style: style.bodyLarge?.copyWith(
                      color: colors.primary,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberPicker(
                  value: hour,
                  minValue: 1,
                  maxValue: 12,
                  infiniteLoop: true,
                  selectedTextStyle: style.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) => setState(() {
                    hour = value;
                  }),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colors.primary,
                    ),
                  ),
                ),
                NumberPicker(
                  value: minute,
                  minValue: 0,
                  maxValue: 59,
                  zeroPad: true,
                  infiniteLoop: true,
                  selectedTextStyle: style.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) => setState(() {
                    minute = value;
                  }),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colors.primary,
                    ),
                  ),
                ),
                NumberPicker(
                  value: periodOffset,
                  minValue: 0,
                  maxValue: 1,
                  selectedTextStyle: style.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) => setState(() {
                    periodOffset = value;
                  }),
                  textMapper: (value) {
                    return value == '0' ? 'AM' : 'PM';
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}

// ---- TimePickerWidget ----

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({
    required this.onChangeSelected,
    this.initialTime,
    super.key,
  });

  final TimeOfDay? initialTime;
  final Function(TimeOfDay) onChangeSelected;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  int hour = 8;
  int minute = 0;
  int periodOffset = 0;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _initialize() {
    if (widget.initialTime != null) {
      TimeOfDay initialTime = widget.initialTime!;
      hour = initialTime.hourOfPeriod;
      minute = initialTime.minute;
      periodOffset = initialTime.period.index;
    }
  }

  void _onDone() {
    TimeOfDay? selectedTime;
    if (periodOffset == 0 && hour == 12) {
      selectedTime = TimeOfDay(hour: 0, minute: minute);
    } else if (periodOffset == 1 && hour == 12) {
      selectedTime = TimeOfDay(hour: 12, minute: minute);
    } else {
      selectedTime = TimeOfDay(
        hour: periodOffset == 1 ? hour + 12 : hour,
        minute: minute,
      );
    }
    widget.onChangeSelected.call(selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NumberPicker(
            value: hour,
            minValue: 1,
            maxValue: 12,
            infiniteLoop: true,
            selectedTextStyle: style.titleLarge?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) => setState(() {
              hour = value;
              _onDone();
            }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colors.primary,
              ),
            ),
          ),
          NumberPicker(
            value: minute,
            minValue: 0,
            maxValue: 59,
            zeroPad: true,
            infiniteLoop: true,
            selectedTextStyle: style.titleLarge?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) => setState(() {
              minute = value;
              _onDone();
            }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colors.primary,
              ),
            ),
          ),
          NumberPicker(
            value: periodOffset,
            minValue: 0,
            maxValue: 1,
            selectedTextStyle: style.titleLarge?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) => setState(() {
              periodOffset = value;
              _onDone();
            }),
            textMapper: (value) {
              return value == '0' ? 'AM' : 'PM';
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
