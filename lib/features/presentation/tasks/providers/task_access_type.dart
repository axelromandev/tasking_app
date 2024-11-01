import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskAccessTypeProvider =
    StateNotifierProvider<_Notifier, TaskAccessType>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<TaskAccessType> {
  _Notifier() : super(TaskAccessType.today);

  void setSearch() {
    state = TaskAccessType.search;
  }

  void setToday() {
    state = TaskAccessType.today;
  }

  void setImportant() {
    state = TaskAccessType.important;
  }

  void setCalendar() {
    state = TaskAccessType.calendar;
  }

  void setList() {
    state = TaskAccessType.list;
  }
}

enum TaskAccessType {
  search,
  today,
  important,
  calendar,
  list,
}
