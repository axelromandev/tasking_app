import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';

abstract interface class ITaskDataSource {
  Future<Task> get(int id);
  Future<List<Task>> getAll();
  Future<Task> add(int listId, String name, [DateTime? reminder]);
  Future<void> update(Task task);
  Future<void> delete(int id);
  Future<void> clearComplete(int listId);
  Future<void> changeList(int taskId, int newListId);
}

class TaskDataSource implements ITaskDataSource {
  final Isar _isar = IsarService.isar;

  @override
  Future<Task> get(int id) async {
    final task = await _isar.tasks.get(id);
    if (task == null) throw Exception('Task not found');
    return task;
  }

  @override
  Future<List<Task>> getAll() async {
    return await _isar.tasks.where().findAll();
  }

  @override
  Future<Task> add(int listId, String value, [DateTime? reminder]) async {
    final task = Task(
      message: value,
      listId: listId,
      reminder: reminder,
      position: 0,
      createAt: DateTime.now(),
    );
    final query = _isar.listTasks.where().filter().idEqualTo(listId);
    final list = await query.findFirst();
    list!.tasks.add(task);
    await _isar.writeTxn(() async {
      task.id = await _isar.tasks.put(task);
      await list.tasks.save();
    });
    return task;
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.delete(id);
    });
  }

  @override
  Future<void> update(Task task) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(task);
    });
  }

  @override
  Future<void> clearComplete(int listId) async {
    await _isar.writeTxn(() async {
      final ref = _isar.tasks.filter();
      final query = ref.listIdEqualTo(listId).completedEqualTo(true);
      await query.deleteAll();
    });
  }

  @override
  Future<void> changeList(int taskId, int newListId) async {
    await _isar.writeTxn(() async {
      final task = await _isar.tasks.get(taskId);
      final oldList = await _isar.listTasks.get(task!.listId);
      final newList = await _isar.listTasks.get(newListId);
      oldList!.tasks.remove(task);
      newList!.tasks.add(task);
      task.listId = newListId;
      await _isar.tasks.put(task);
      await oldList.tasks.save();
      await newList.tasks.save();
    });
  }
}
