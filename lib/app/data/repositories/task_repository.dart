import '../../domain/domain.dart';

abstract interface class TaskRepository {
  Future<Task?> get(int id);
  Future<List<Task>> getAll();
  Future<void> add(int groupId, String name);
  Future<void> update(Task task);
  Future<void> delete(int id);
  Future<void> clearComplete(int groupId);
}
