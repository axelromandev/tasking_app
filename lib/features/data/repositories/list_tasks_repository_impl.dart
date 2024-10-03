import 'dart:ui';

import 'package:tasking/features/data/data.dart';
import 'package:tasking/features/domain/domain.dart';

class ListTasksRepositoryImpl extends ListTasksRepository {
  ListTasksRepositoryImpl([ListTasksDataSource? dataSource])
      : _dataSource = dataSource ?? ListTasksDataSourceImpl();

  final ListTasksDataSource _dataSource;

  @override
  Future<ListTasks> add(String name, Color color) {
    return _dataSource.add(name, color);
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
  Future<void> update(int id, String title, Color color) {
    return _dataSource.update(id, title, color);
  }

  @override
  Future<void> updateArchived(int id, bool archived) {
    return _dataSource.updateArchived(id, archived);
  }
}
