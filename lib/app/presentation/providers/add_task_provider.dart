import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/core/core.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../modals/select_date_time_modal.dart';

final addTaskProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final group = ref.read(homeProvider).group!;
  final getAll = ref.read(homeProvider.notifier).getAll;
  return _Notifier(group: group, getAll: getAll);
});

class _Notifier extends StateNotifier<_State> {
  final GroupTasks group;
  final Future<void> Function() getAll;

  _Notifier({
    required this.group,
    required this.getAll,
  }) : super(_State());

  final focusNode = FocusNode();
  final controller = TextEditingController();
  final DateTime _now = DateTime.now();
  final _taskDataSource = TaskDataSource();

  void onNameChanged(String value) {
    state = state.copyWith(name: value);
  }

  void onAddDueDate(BuildContext context) async {
    final dateToday = DateTime(_now.year, _now.month, _now.day, 23, 59);
    final dateTomorrow = DateTime(_now.year, _now.month, _now.day + 1, 23, 59);

    await showModalBottomSheet<DateTime?>(
      context: context,
      builder: (_) => Card(
        margin: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () => Navigator.pop(context, dateToday),
                  iconColor: Theme.of(context).colorScheme.primary,
                  leading: const Icon(BoxIcons.bx_calendar),
                  title: Text(S.of(context).calendar_today),
                  trailing: Text(
                    DateFormat('EEEE, d MMMM').format(dateToday).toString(),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pop(context, dateTomorrow),
                  iconColor: Theme.of(context).colorScheme.primary,
                  leading: const Icon(BoxIcons.bx_calendar),
                  title: Text(S.of(context).calendar_tomorrow),
                  trailing: Text(DateFormat('EEEE, d MMMM')
                      .format(dateTomorrow)
                      .toString()),
                ),
                const Divider(color: Colors.white12),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    _customDateTime(context);
                  },
                  iconColor: Theme.of(context).colorScheme.primary,
                  leading: const Icon(BoxIcons.bx_calendar),
                  title: Text(S.of(context).calendar_custom),
                ),
                if (Platform.isAndroid) const Gap(defaultPadding),
              ],
            ),
          ),
        ),
      ),
    ).then((value) {
      if (value != null) {
        state = state.copyWith(dueDate: value);
      }
    });
  }

  void _customDateTime(BuildContext context) async {
    await showModalBottomSheet<DueDate?>(
      context: context,
      elevation: 0,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: MyColors.backgroundDark,
      builder: (_) => const SelectDateTimeModal(),
    ).then((value) {
      if (value != null) {
        state = state.copyWith(
          dueDate: value.date,
          isReminder: value.isReminder,
        );
      }
    });
  }

  void onEditDueDate(BuildContext context) async {
    await showModalBottomSheet<DueDate?>(
      context: context,
      elevation: 0,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: MyColors.backgroundDark,
      builder: (_) => SelectDateTimeModal(
        initialDueDate: DueDate(
          date: state.dueDate!,
          isReminder: state.isReminder,
        ),
      ),
    ).then((value) {
      if (value != null) {
        state = state.copyWith(
          dueDate: value.date,
          isReminder: value.isReminder,
        );
      }
    });
  }

  void onRemoveDueDate() {
    state = state.removeDueDate();
  }

  void onSubmit(BuildContext context) async {
    final name = state.name.trim();
    if (name.isEmpty) return;
    DueDate? dueDate;
    if (state.dueDate != null) {
      dueDate = DueDate(date: state.dueDate, isReminder: state.isReminder);
    }
    final task =
        await _taskDataSource.add(group.id, name, dueDate).then((task) {
      controller.clear();
      focusNode.requestFocus();
      state = state.reset();
      return task;
    });
    if (state.isReminder && state.dueDate != null) {
      await NotificationService.showScheduleNotification(
        id: task.id,
        title: task.message,
        body: DateFormat('E, d MMM y,')
            .add_jm()
            .format(task.dueDate!.date!)
            .toString(),
        scheduledDate: task.dueDate!.date!,
      );
    }
    await getAll();
  }
}

class _State {
  final String name;
  final DateTime? dueDate;
  final bool isReminder;

  _State({
    this.name = '',
    this.dueDate,
    this.isReminder = false,
  });

  _State copyWith({
    String? name,
    DateTime? dueDate,
    bool? isReminder,
  }) {
    return _State(
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      isReminder: isReminder ?? this.isReminder,
    );
  }

  _State removeDueDate() {
    return _State(
      name: name,
      dueDate: null,
      isReminder: false,
    );
  }

  _State reset() {
    return _State();
  }
}
