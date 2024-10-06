import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

class ListTasksRepositoryImpl extends ListTasksRepository {
  ListTasksRepositoryImpl([ListTasksDataSource? dataSource])
      : _dataSource = dataSource ?? ListTasksDataSourceImpl();

  final ListTasksDataSource _dataSource;

  @override
  Future<ListTasks> add(ListTasks list) {
    return _dataSource.add(list);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }

  @override
  Future<ListTasks> get(int id) {
    return _dataSource.get(id);
  }

  @override
  Future<List<ListTasks>> getAll() {
    return _dataSource.getAll();
  }

  @override
  Future<void> update(ListTasks list) {
    return _dataSource.update(list);
  }
}
