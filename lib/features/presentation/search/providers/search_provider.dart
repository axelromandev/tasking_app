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
    state = state.copyWith(isSearching: true);
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
}

class _State {
  _State({
    this.isSearching = false,
    this.tasks = const [],
  });

  final bool isSearching;
  final List<Task> tasks;

  _State copyWith({
    bool? isSearching,
    List<Task>? tasks,
  }) {
    return _State(
      isSearching: isSearching ?? this.isSearching,
      tasks: tasks ?? this.tasks,
    );
  }
}
