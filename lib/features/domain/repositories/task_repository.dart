import '../../data/data.dart';
import '../domain.dart';

abstract interface class ITaskRepository {
  Future<Task> get(int id);
  Future<List<Task>> getAll();
  Future<Task> add(int listId, String name, [DateTime? reminder]);
  Future<void> update(Task task);
  Future<void> delete(int id);
  Future<void> clearComplete(int listId);
  Future<void> changeList(int taskId, int newListId);
}

class TaskRepository extends ITaskRepository {
  final ITaskDataSource _dataSource = TaskDataSource();

  @override
  Future<Task> add(int listId, String name, [DateTime? reminder]) {
    return _dataSource.add(listId, name, reminder);
  }

  @override
  Future<void> clearComplete(int listId) {
    return _dataSource.clearComplete(listId);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }

  @override
  Future<Task> get(int id) {
    return _dataSource.get(id);
  }

  @override
  Future<List<Task>> getAll() {
    return _dataSource.getAll();
  }

  @override
  Future<void> update(Task task) {
    return _dataSource.update(task);
  }

  @override
  Future<void> changeList(int taskId, int newListId) {
    return _dataSource.changeList(taskId, newListId);
  }
}
