import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tasking/app/domain/domain.dart';

import '../../../core/core.dart';
import '../repositories/group_repository.dart';

class GroupDataSource implements GroupRepository {
  final Isar _isar = IsarService.isar;

  @override
  Future<List<GroupTasks>> fetchAll() async {
    return await _isar.groupTasks.where().findAll();
  }

  @override
  Future<GroupTasks?> get(int id) async {
    return await _isar.groupTasks.get(id);
  }

  @override
  Future<GroupTasks> add(String name, IconData icon) async {
    return await _isar.writeTxn(() async {
      final id = await _isar.groupTasks.put(
        GroupTasks(
          name: name,
          icon: GroupIcon(
            codePoint: icon.codePoint,
            fontFamily: icon.fontFamily,
            fontPackage: icon.fontPackage,
          ),
        ),
      );
      final group = await _isar.groupTasks.get(id);
      return group!;
    });
  }

  @override
  Future<void> update(GroupTasks group) async {
    await _isar.writeTxn(() async {
      await _isar.groupTasks.put(group);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.filter().groupIdEqualTo(id).deleteAll();
      await _isar.groupTasks.delete(id);
    });
  }

  @override
  Future<void> restore() async {
    await _isar.writeTxn(() async {
      await _isar.groupTasks.where().deleteAll();
    });
  }
}
