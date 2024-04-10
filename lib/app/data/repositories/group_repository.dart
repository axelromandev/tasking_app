import 'package:flutter/material.dart';

import '../../domain/domain.dart';

abstract interface class GroupRepository {
  Future<List<ListTasks>> fetchAll();
  Future<ListTasks?> get(int id);
  Future<ListTasks> add(String name, IconData icon);
  Future<void> update(ListTasks group);
  Future<void> delete(int id);
}
