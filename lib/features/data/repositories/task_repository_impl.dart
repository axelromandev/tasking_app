import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

class TaskRepositoryImpl extends TaskRepository {
  TaskRepositoryImpl([TaskDataSource? dataSource])
      : _dataSource = dataSource ?? TaskDataSourceImpl();

  final TaskDataSource _dataSource;

  @override
  Future<Task> get(int id) {
    return _dataSource.get(id);
  }

  @override
  Future<Task> add(Task task) {
    return _dataSource.add(task);
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
  Future<void> update(Task task) {
    return _dataSource.update(task);
  }

  @override
  Future<void> toggleCompleted(int id) {
    return _dataSource.toggleCompleted(id);
  }
}
