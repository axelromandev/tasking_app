import 'package:flutter/material.dart';
import 'package:tasking/domain/domain.dart';

abstract class ListTasksDataSource {
  Future<List<ListTasks>> getAll();
  Future<ListTasks> get(int id);
  Future<ListTasks> add(String name, Color color);
  Future<void> delete(int id);
  Future<void> update(int id, String title, Color color);
  Future<void> updateArchived(int id, bool archived);
}
