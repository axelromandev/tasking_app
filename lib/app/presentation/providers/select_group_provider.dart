import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';

final selectGroupProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    initialize();
  }

  final _groupDataSource = GroupDataSource();

  Future<void> initialize() async {
    final groups = await _groupDataSource.fetchAll();
    state = state.copyWith(groups: groups);
  }

  Future<void> onDeleteGroup(ListTasks group) async {
    await _groupDataSource.delete(group.id);
    initialize();
  }
}

class _State {
  final List<ListTasks> groups;

  _State({this.groups = const []});

  _State copyWith({List<ListTasks>? groups}) {
    return _State(groups: groups ?? this.groups);
  }
}
