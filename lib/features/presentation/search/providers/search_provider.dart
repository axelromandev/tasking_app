import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

final searchProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State());

  final _debounce = Debounce();
  final _taskRepository = TaskRepositoryImpl();

  void onChangeSearch(String value) {
    state = state.copyWith(isSearching: true, searchValue: value);
    _debounce.run(() {
      if (value.isEmpty) {
        state = state.copyWith(tasks: [], isSearching: false);
        return;
      }
      _taskRepository.search(value).then((tasks) {
        state = state.copyWith(tasks: tasks, isSearching: false);
      });
    });
  }

  void refresh() {
    onChangeSearch(state.searchValue);
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

  void delete(int id) {}
}

class _State {
  _State({
    this.isSearching = false,
    this.tasks = const [],
    this.searchValue = '',
  });

  final bool isSearching;
  final List<Task> tasks;
  final String searchValue;

  _State copyWith({
    bool? isSearching,
    List<Task>? tasks,
    String? searchValue,
  }) {
    return _State(
      isSearching: isSearching ?? this.isSearching,
      tasks: tasks ?? this.tasks,
      searchValue: searchValue ?? this.searchValue,
    );
  }
}
