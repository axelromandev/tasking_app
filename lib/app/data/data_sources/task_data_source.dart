import '../../domain/domain.dart';

abstract class TaskDataSource {
  Future<List<Task>> getAll();
  Future<Task> create(Task task);
}

class TaskDataSourceImpl {
  Future<List<Task>> getAll() async {
    return [];
  }

  Future<Task> create(Task task) async {
    return task;
  }
}
