import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

final myDayProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _initialize();
  }

  final _taskRepository = TaskRepositoryImpl();

  Future<void> _initialize() async {
    try {
      final today = DateTime.now();
      _taskRepository.getByDate(today).then((tasks) {
        state = state.copyWith(tasks: tasks);
      });
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class _State {
  _State({
    this.isLoading = true,
    this.hideCompletedTasks = false,
    this.tasks = const [],
  });

  final bool isLoading;
  final bool hideCompletedTasks;
  final List<Task> tasks;

  _State copyWith({
    bool? isLoading,
    bool? hideCompletedTasks,
    List<Task>? tasks,
  }) {
    return _State(
      isLoading: isLoading ?? this.isLoading,
      hideCompletedTasks: hideCompletedTasks ?? this.hideCompletedTasks,
      tasks: tasks ?? this.tasks,
    );
  }
}
