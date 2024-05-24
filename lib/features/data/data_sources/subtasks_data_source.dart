import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';

abstract class ISubtasksDataSource {
  Future<SubTask> add(int taskId, String name);
  Future<void> update(SubTask subTask);
}

class SubtasksDataSource extends ISubtasksDataSource {
  final Isar _isar = IsarService.isar;

  @override
  Future<SubTask> add(int taskId, String name) async {
    final subtask = SubTask(
      taskId: taskId,
      message: name,
    );
    final query = _isar.tasks.where().filter().idEqualTo(taskId);
    final task = await query.findFirst();
    task!.subtasks.add(subtask);
    await _isar.writeTxn(() async {
      subtask.id = await _isar.subTasks.put(subtask);
      await task.subtasks.save();
    });
    return subtask;
  }

  @override
  Future<void> update(SubTask subTask) async {
    await _isar.writeTxn(() async {
      await _isar.subTasks.put(subTask);
    });
  }
}
