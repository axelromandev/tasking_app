import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../repositories/task_repository.dart';

class TaskDataSource implements TaskRepository {
  final Isar _isar = IsarService.isar;

  @override
  Future<Task?> get(int id) async {
    return await _isar.tasks.get(id);
  }

  @override
  Future<List<Task>> getAll() async {
    return await _isar.tasks.where().findAll();
  }

  @override
  Future<void> add(int groupId, String value) async {
    final task = Task(
      message: value,
      groupId: groupId,
      createAt: DateTime.now(),
    );
    final query = _isar.groupTasks.where().filter().idEqualTo(groupId);
    final group = await query.findFirst();
    group!.tasks.add(task);
    await _isar.writeTxn(() async {
      await _isar.tasks.put(task);
      await group.tasks.save();
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.delete(id);
    });
  }

  @override
  Future<void> restore() async {
    await _isar.writeTxn(() async {
      await _isar.tasks.where().deleteAll();
    });
  }

  @override
  Future<void> update(Task task) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.put(task);
    });
  }

  @override
  Future<void> clearComplete(int groupId) async {
    await _isar.writeTxn(() async {
      final ref = _isar.tasks.filter();
      final query = ref.groupIdEqualTo(groupId).isCompletedIsNotNull();
      await query.deleteAll();
    });
  }
}
