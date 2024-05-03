import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import 'select_list_id_provider.dart';

final listTasksProvider =
    StateNotifierProvider.autoDispose<_Notifier, ListTasks?>((ref) {
  final listId = ref.watch(selectListIdProvider);

  return _Notifier(listId);
});

class _Notifier extends StateNotifier<ListTasks?> {
  final int listId;

  _Notifier(this.listId) : super(null) {
    _load(listId);
  }

  final _listTasksRepository = ListTasksRepository();

  Future<void> _load(int listId) async {
    final list = await _listTasksRepository.get(listId);
    state = list;
  }

  Future<void> refresh() async {
    await _load(state!.id);
  }

  Future<void> onPinned() async {
    if (state == null) return;
    state!.isPinned = !state!.isPinned;
    await _listTasksRepository.update(state!);
    await _load(state!.id);
  }

  Future<void> onDelete() async {
    if (state == null) return;
    //TODO: check if list has tasks
    await _listTasksRepository.delete(state!.id);
    state = null;
  }
}
