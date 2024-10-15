import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/domain/domain.dart';

final calendarProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State());

  void onSelectedDate(DateTime value) {
    state = state.copyWith(selectedDate: value);
  }
}

class _State {
  _State({
    this.selectedDate,
    this.tasksDay = const [],
  });

  final DateTime? selectedDate;
  final List<Task> tasksDay;

  _State copyWith({
    DateTime? selectedDate,
    List<Task>? tasksDay,
  }) {
    return _State(
      selectedDate: selectedDate ?? this.selectedDate,
      tasksDay: tasksDay ?? this.tasksDay,
    );
  }
}
