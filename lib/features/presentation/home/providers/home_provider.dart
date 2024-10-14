import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

final homeProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State());

  final _taskRepository = TaskRepositoryImpl();

  Future<List<Task>> getTodayTasks() async {
    return await _taskRepository.getTodayTasks();
  }

  void onChangeView(int value) {
    if (state.currentIndex == value) return;
    state = state.copyWith(currentIndex: value);
  }
}

class _State {
  _State({
    this.currentIndex = 0,
  });

  final int currentIndex;

  _State copyWith({
    int? currentIndex,
  }) {
    return _State(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
