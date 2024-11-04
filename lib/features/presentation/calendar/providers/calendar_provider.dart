import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

final calendarProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _initialize();
  }

  final _taskRepository = TaskRepositoryImpl();

  void _initialize() {
    final DateTime date = state.selectedDate ?? DateTime.now();
    _taskRepository.getByDate(date).then((tasks) {
      final Map<String, List<Task>> groups = {};

      for (final task in tasks) {
        final String listaTitulo = task.listTitle ?? '';
        if (groups.containsKey(listaTitulo)) {
          groups[listaTitulo]!.add(task);
        } else {
          groups[listaTitulo] = [task];
        }
      }

      state = state.copyWith(groups: groups, isLoading: false);
    });
  }

  void refresh() {
    state = state.copyWith(isLoading: true);
    _initialize();
  }

  void onSelectedDate(DateTime value) {
    state = state.copyWith(selectedDate: value);
    _initialize();
  }

  void toggleCompleted(Task task) {
    final completedAt = task.completedAt == null ? DateTime.now() : null;
    _taskRepository.update(task.id, {
      'completed_at': completedAt?.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    }).then((_) {
      refresh();
    });
  }

  void toggleImportant(Task task) {
    _taskRepository.update(task.id, {
      'is_important': task.isImportant ? 0 : 1,
      'updated_at': DateTime.now().toIso8601String(),
    }).then((_) {
      refresh();
    });
  }
}

class _State {
  _State({
    this.isLoading = true,
    this.selectedDate,
    this.groups = const {},
  });

  final bool isLoading;
  final DateTime? selectedDate;
  final Map<String, List<Task>> groups;

  _State copyWith({
    bool? isLoading,
    DateTime? selectedDate,
    Map<String, List<Task>>? groups,
  }) {
    return _State(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      groups: groups ?? this.groups,
    );
  }
}
