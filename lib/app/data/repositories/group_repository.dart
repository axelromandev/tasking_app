import 'package:flutter/material.dart';
import 'package:tasking/app/domain/domain.dart';

abstract interface class GroupRepository {
  Future<List<GroupTasks>> fetchAll();
  Future<GroupTasks?> get(int id);
  Future<GroupTasks> add(String name, IconData icon);
  Future<void> update(GroupTasks group);
}
