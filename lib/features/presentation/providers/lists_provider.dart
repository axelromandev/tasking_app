import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

final listsProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _load();
  }

  final _listTasksRepository = ListTasksRepositoryImpl();
  final _taskRepository = TaskRepositoryImpl();

  Future<void> _load() async {
    final lists = await _listTasksRepository.getAll();
    if (lists.isEmpty) {
      state = state.empty();
      return;
    }

    final listsArchived = lists.where((list) => list.archived).toList();
    final listNotArchived = lists.where((list) => !list.archived).toList();

    for (final list in listNotArchived) {
      final tasks = await _taskRepository.getByListId(list.id);
      list.tasks = tasks;
    }

    state = state.copyWith(
      lists: listNotArchived,
      listsArchived: listsArchived,
      isLoading: false,
    );
  }

  Future<void> refresh() async {
    _load();
  }

  List<Task> getRecentTasks() {
    final List<Task> tasks = [];
    for (final list in state.lists) {
      tasks.addAll(list.tasks);
    }
    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return tasks.take(5).toList();
  }

  Future<void> onUnarchiveList(int listId) async {
    _listTasksRepository.updateArchived(listId, false).then((_) {
      _load();
    });
  }
}

class _State {
  _State({
    this.isLoading = true,
    this.lists = const [],
    this.listsArchived = const [],
  });

  final bool isLoading;
  final List<ListTasks> lists;
  final List<ListTasks> listsArchived;

  _State copyWith({
    bool? isLoading,
    List<ListTasks>? lists,
    List<ListTasks>? listsArchived,
  }) {
    return _State(
      isLoading: isLoading ?? this.isLoading,
      lists: lists ?? this.lists,
      listsArchived: listsArchived ?? this.listsArchived,
    );
  }

  _State empty() {
    return _State(lists: [], listsArchived: [], isLoading: false);
  }
}
