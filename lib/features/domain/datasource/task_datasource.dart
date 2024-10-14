import 'package:tasking/features/domain/domain.dart';

abstract class TaskDataSource {
  Future<Task> get(int id);
  Future<List<Task>> getByListId(int id);
  Future<List<Task>> getTodayTasks();
  Future<List<Task>> getReminders();
  Future<Task> add(Task task);
  Future<void> update(Task task);
  Future<void> delete(int id);
  Future<void> deleteReminder(int id);
  Future<void> toggleCompleted(int id);
}
