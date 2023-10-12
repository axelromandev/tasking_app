import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';

abstract class TaskDataSource {
  Future<List<Task>> getAll();
  Future<void> write(Task task);
}

class TaskDataSourceImpl extends TaskDataSource {
  @override
  Future<List<Task>> getAll() async {
    final tasks = IsarService.isar.tasks;
    final list = await tasks.where().findAll();
    return list;
  }

  @override
  Future<void> write(Task task) async {
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.tasks.put(task);
    });
  }
}
