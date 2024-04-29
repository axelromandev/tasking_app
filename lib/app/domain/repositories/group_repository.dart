import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../domain.dart';

abstract interface class IGroupRepository {
  Future<List<ListTasks>> fetchAll();
  Future<ListTasks?> get(int id);
  Future<ListTasks> add(String name, IconData icon);
  Future<void> update(ListTasks group);
  Future<void> delete(int id);
}

class GroupRepository extends IGroupRepository {
  final IGroupDataSource _dataSource = GroupDataSource();

  @override
  Future<ListTasks> add(String name, IconData icon) {
    return _dataSource.add(name, icon);
  }

  @override
  Future<void> delete(int id) {
    return _dataSource.delete(id);
  }

  @override
  Future<List<ListTasks>> fetchAll() {
    return _dataSource.fetchAll();
  }

  @override
  Future<ListTasks?> get(int id) {
    return _dataSource.get(id);
  }

  @override
  Future<void> update(ListTasks group) {
    return _dataSource.update(group);
  }
}
