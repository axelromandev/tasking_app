import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

final calendarProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _init();
  }

  final _taskRepository = TaskRepositoryImpl();

  void _init() {
    final DateTime date = state.selectedDate ?? DateTime.now();
    _taskRepository.getByDate(date).then((value) {
      state = state.copyWith(tasksDay: value);
    });
  }

  void onSelectedDate(DateTime value) {
    state = state.copyWith(selectedDate: value);
    _init();
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
