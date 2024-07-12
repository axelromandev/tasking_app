import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../domain.dart';

abstract interface class IListTasksRepository {
  Future<List<ListTasks>> getAll();
  Future<ListTasks> get(int id);
  Future<ListTasks> add(String name, Color color);
  Future<void> delete(int id);
  Future<void> update(int id, String title, Color color);
  Future<void> updatePinned(int id, bool pinned);
  Future<void> updateArchived(int id, bool archived);
}

class ListTasksRepository extends IListTasksRepository {
  final IListTasksDataSource _dataSource = ListTasksDataSource();

  @override
  Future<List<ListTasks>> getAll() {
    return _dataSource.getAll();
  }

  @override
  Future<ListTasks> add(String name, Color color) {
    return _dataSource.add(name, color);
  }

  @override
  Future<ListTasks> get(int id) {
    return _dataSource.get(id);
  }

  @override
  Future<void> update(int id, String title, Color color) {
    return _dataSource.update(id, title, color);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }

  @override
  Future<void> updatePinned(int id, bool pinned) {
    return _dataSource.updatePinned(id, pinned);
  }

  @override
  Future<void> updateArchived(int id, bool archived) {
    return _dataSource.updateArchived(id, archived);
  }
}
