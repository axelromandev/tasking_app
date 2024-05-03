import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/domain.dart';
import 'list_tasks_provider.dart';
import 'select_list_id_provider.dart';

final taskAddModalProvider =
    StateNotifierProvider.autoDispose<_Notifier, _State>((ref) {
  final listId = ref.read(selectListIdProvider);
  final refresh = ref.read(listTasksProvider.notifier).refresh;

  return _Notifier(listId: listId, refresh: refresh);
});

class _Notifier extends StateNotifier<_State> {
  final Future<void> Function() refresh;

  _Notifier({
    required int listId,
    required this.refresh,
  }) : super(_State(listId: listId));

  final controller = TextEditingController();

  final _taskRepository = TaskRepository();

  void onNameChanged(String value) {
    state = state.copyWith(name: value.trim());
  }

  Future<void> onSubmit() async {
    try {
      await _taskRepository.add(state.listId, state.name);
      refresh();
    } catch (e) {
      _showToast(e.toString());
    } finally {
      _clean();
    }
  }

  Future<void> onMicrophone() async {
    try {
      //TODO: Implementar a funcionalidade de reconhecimento de voz
    } catch (e) {
      _showToast(e.toString());
    }
  }

  void _clean() {
    controller.clear();
    state = state.copyWith(name: '');
  }

  void _showToast(String e) {
    Fluttertoast.showToast(
      msg: e,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class _State {
  final int listId;
  final String name;

  _State({
    required this.listId,
    this.name = '',
  });

  _State copyWith({
    String? name,
  }) {
    return _State(
      listId: listId,
      name: name ?? this.name,
    );
  }
}
