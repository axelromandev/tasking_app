import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../../domain/domain.dart';
import '../widgets/widgets.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeNotifier(this.ref) : super(HomeState()) {
    initialize();
  }

  final _prefs = SharedPrefs();
  // final _localRepository = LocalRepository();
  final _groupRepository = GroupRepository();
  final _taskRepository = TaskRepository();

  Future<void> initialize() async {
    final groupId = _prefs.getValue<int>(Keys.groupId)!;
    final group = await _groupRepository.get(groupId);
    state = state.copyWith(
      group: group,
      tasks: group!.tasks.toList(),
    );
  }

  void onSelectGroup(ListTasks group) {
    _prefs.setKeyValue<int>(Keys.groupId, group.id);
    state = state.copyWith(group: group, tasks: group.tasks.toList());
  }

  Future<void> getAll() async {
    final group = await _groupRepository.get(state.group!.id);
    final tasks = group!.tasks.toList();
    state = state.copyWith(tasks: tasks);
  }

  Future<void> onClearCompleted() async {
    state = state.copyWith(isShowCompleted: false);
    final groupId = state.group!.id;
    await _taskRepository.clearComplete(groupId);
    getAll();
  }

  void onToggleShowCompleted() {
    state = state.copyWith(isShowCompleted: !state.isShowCompleted);
  }

  Future<void> onToggleCheck(Task task) async {
    task.isCompleted = task.isCompleted == null ? DateTime.now() : null;
    await _taskRepository.update(task);
    getAll();
  }

  Future<void> onRestore() async {
    BuildContext context = navigatorGlobalKey.currentContext!;
    await showModalBottomSheet<bool?>(
      context: context,
      elevation: 0,
      builder: (_) => Card(
        margin: EdgeInsets.zero,
        child: Container(
          margin: const EdgeInsets.all(24),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(S.of(context).dialog_restore_title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    S.of(context).dialog_restore_subtitle,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Gap(defaultPadding),
                CustomFilledButton(
                  onPressed: () => context.pop(true),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  child: Text(S.of(context).settings_button_restore_app),
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((value) async {
      if (value == null) return;
      _restore();
      context.pop();
    });
  }

  Future<void> _restore() async {
    // await NotificationService.cancelAll();
    // await _localRepository.restore();
    // final group = await _groupRepository.add(
    //   S.current.default_group_1,
    //   BoxIcons.bx_list_ul,
    // );
    // await _groupRepository.add(
    //   S.current.default_group_2,
    //   BoxIcons.bx_cart,
    // );
    // await _groupRepository.add(
    //   S.current.default_group_3,
    //   BoxIcons.bx_briefcase,
    // );
    // _prefs.setKeyValue<int>(Keys.groupId, group.id);
    // state = state.copyWith(group: group, tasks: []);
  }
}

class HomeState {
  final bool isShowCompleted;
  final ListTasks? group;
  final List<Task> tasks;
  final DateTime? date;

  HomeState({
    this.isShowCompleted = false,
    this.group,
    this.tasks = const [],
    this.date,
  });

  HomeState copyWith({
    bool? isShowCompleted,
    ListTasks? group,
    List<Task>? tasks,
    DateTime? date,
  }) {
    return HomeState(
      isShowCompleted: isShowCompleted ?? this.isShowCompleted,
      group: group ?? this.group,
      tasks: tasks ?? this.tasks,
      date: date,
    );
  }
}
