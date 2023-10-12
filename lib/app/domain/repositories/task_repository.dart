import '../entities/entities.dart';

abstract class TaskRepository {
  Future<List<Task>> getAll();
  Future<Task> findById(int id);
  Future<Task> create(Task task);
  Future<Task> update(Task task);
  Future<void> delete(int id);
}
