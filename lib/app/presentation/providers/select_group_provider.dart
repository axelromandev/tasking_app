import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/app/data/data.dart';
import 'package:tasking/app/domain/domain.dart';

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

  Future<void> onDeleteGroup(GroupTasks group) async {
    await _groupDataSource.delete(group.id);
    initialize();
  }
}

class _State {
  final List<GroupTasks> groups;

  _State({this.groups = const []});

  _State copyWith({List<GroupTasks>? groups}) {
    return _State(groups: groups ?? this.groups);
  }
}
