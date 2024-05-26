import '../../data/data.dart';
import '../domain.dart';

abstract class ISubtasksRepository {
  Future<SubTask> add(int taskId, String name);
  Future<void> update(SubTask subTask);
  Future<void> delete(int id);
}

class SubtasksRepository extends ISubtasksRepository {
  final ISubtasksDataSource _dataSource = SubtasksDataSource();

  @override
  Future<SubTask> add(int taskId, String name) {
    return _dataSource.add(taskId, name);
  }

  @override
  Future<void> update(SubTask subTask) {
    return _dataSource.update(subTask);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }
}
