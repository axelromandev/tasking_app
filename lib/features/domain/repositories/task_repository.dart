import '../../data/data.dart';
import '../domain.dart';

abstract interface class ITaskRepository {
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

class TaskRepository extends ITaskRepository {
  final ITaskDataSource _dataSource = TaskDataSource();

  @override
  Future<Task> add(int listId, String title) {
    return _dataSource.add(listId, title);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }

  @override
  Future<List<Task>> getByListId(int id) {
    return _dataSource.getByListId(id);
  }

  @override
  Future<void> updateCompleted(int id, bool completed) {
    return _dataSource.updateCompleted(id, completed);
  }

  @override
  Future<void> updateNote(int id, String note) {
    return _dataSource.updateNote(id, note);
  }

  @override
  Future<void> updateTitle(int id, String title) {
    return _dataSource.updateTitle(id, title);
  }

  @override
  Future<void> updateReminder(int id, DateTime reminder) {
    return _dataSource.updateReminder(id, reminder);
  }

  @override
  Future<List<Task>> getReminders() {
    return _dataSource.getReminders();
  }

  @override
  Future<void> deleteReminder(int id) {
    return _dataSource.deleteReminder(id);
  }
}
