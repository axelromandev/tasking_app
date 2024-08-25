import 'package:tasking/domain/domain.dart';

abstract class TaskDataSource {
  Future<List<Task>> getByListId(int id);
  Future<List<Task>> getReminders();
  Future<Task> add(int listId, String title);
  Future<void> updateReminder(int id, DateTime reminder);
  Future<void> updateCompleted(int id, bool completed);
  Future<void> updateTitle(int id, String title);
  Future<void> updateNote(int id, String note);
  Future<void> delete(int id);
  Future<void> deleteReminder(int id);
}
