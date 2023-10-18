import '../../domain/domain.dart';
import '../data_sources/data_sources.dart';

abstract class TaskRepository {
  Future<Task?> get(int id);
  Future<List<Task>> getAll();
  Future<void> write(Task task);
  Future<void> delete(int id);
}

class TaskRepositoryImpl extends TaskRepository {
  final TaskDataSource _dataSource = TaskDataSourceImpl();

  @override
  Future<Task?> get(int id) {
    return _dataSource.get(id);
  }

  @override
  Future<List<Task>> getAll() {
    return _dataSource.getAll();
  }

  @override
  Future<void> write(Task task) {
    return _dataSource.write(task);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }
}
