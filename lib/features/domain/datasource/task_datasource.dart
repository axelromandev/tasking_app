import 'package:tasking/features/domain/domain.dart';

abstract class TaskDataSource {
  Future<Task> get(int id);
  Future<List<Task>> getByDate(DateTime value);
  Future<List<Task>> getByListId(int id);
  Future<List<Task>> getReminders();
  Future<Task> add(Task task);
  Future<void> update(int id, Map<String, dynamic> data);
  Future<void> delete(int id);
  Future<void> deleteReminder(int id);
}
