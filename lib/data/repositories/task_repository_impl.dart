import 'package:tasking/data/data.dart';
import 'package:tasking/domain/domain.dart';

class TaskRepositoryImpl extends TaskRepository {
  TaskRepositoryImpl([TaskDataSource? dataSource])
      : _dataSource = dataSource ?? TaskDataSourceImpl();

  final TaskDataSource _dataSource;

  @override
  Future<Task> add(int listId, String title) {
    return _dataSource.add(listId, title);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }

  @override
  Future<void> deleteReminder(int id) {
    return _dataSource.deleteReminder(id);
  }

  @override
  Future<List<Task>> getByListId(int id) {
    return _dataSource.getByListId(id);
  }

  @override
  Future<List<Task>> getReminders() {
    return _dataSource.getReminders();
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
  Future<void> updateReminder(int id, DateTime reminder) {
    return _dataSource.updateReminder(id, reminder);
  }

  @override
  Future<void> updateTitle(int id, String title) {
    return _dataSource.updateTitle(id, title);
  }
}
