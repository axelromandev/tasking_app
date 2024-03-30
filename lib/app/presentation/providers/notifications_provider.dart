import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';

final notificationsProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final status = await Permission.notification.request();
    state = state.copyWith(isGrantedNotification: status.isGranted);
  }

  Future<void> onToggleReminder(bool value) async {
    if (!state.isGrantedNotification) return;
    state = state.copyWith(isEnableReminder: value);
  }

  Future<void> onSelectTime(BuildContext context) async {
    await showScrollTimePicker(
      context: context,
      initialTime: state.reminder,
      onSelected: (time) {
        state = state.copyWith(reminder: time);
      },
    );
  }
}

class _State {
  final bool isGrantedNotification;
  final bool isEnableReminder;
  final TimeOfDay reminder;

  _State({
    this.isGrantedNotification = false,
    this.isEnableReminder = false,
    this.reminder = const TimeOfDay(hour: 8, minute: 0),
  });

  _State copyWith({
    bool? isGrantedNotification,
    bool? isEnableReminder,
    TimeOfDay? reminder,
  }) {
    return _State(
      isGrantedNotification:
          isGrantedNotification ?? this.isGrantedNotification,
      isEnableReminder: isEnableReminder ?? this.isEnableReminder,
      reminder: reminder ?? this.reminder,
    );
  }

  _State clean() {
    return _State();
  }
}
