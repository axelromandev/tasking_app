import '../../data/data.dart';
import '../domain.dart';

abstract interface class ITaskRepository {
  Future<Task> get(int id);
  Future<List<Task>> getByListId(int id);
  Future<Task> add(int listId, String title);
  Future<void> updateCompleted(int id, bool completed);
  Future<void> updateTitle(int id, String title);
  Future<void> updateNote(int id, String note);
  Future<void> delete(int id);
  Future<void> clearComplete(int listId);
  Future<void> changeList(int taskId, int newListId);
}

class TaskRepository extends ITaskRepository {
  final ITaskDataSource _dataSource = TaskDataSource();

  @override
  Future<Task> add(int listId, String title) {
    return _dataSource.add(listId, title);
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
  Future<void> changeList(int taskId, int newListId) {
    return _dataSource.changeList(taskId, newListId);
  }
}
