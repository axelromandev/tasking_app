import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../../domain/repositories/group_repository.dart';

class GroupDataSource implements GroupRepository {
  final Isar _isar = IsarService.isar;

  @override
  Future<List<ListTasks>> fetchAll() async {
    return await _isar.listTasks.where().findAll();
  }

  @override
  Future<ListTasks?> get(int id) async {
    return await _isar.listTasks.get(id);
  }

  @override
  Future<ListTasks> add(String name, IconData icon) async {
    return await _isar.writeTxn(() async {
      final id = await _isar.listTasks.put(
        ListTasks(
          name: name,
          icon: ListIconData(
            codePoint: icon.codePoint,
            fontFamily: icon.fontFamily,
            fontPackage: icon.fontPackage,
          ),
        ),
      );
      final group = await _isar.listTasks.get(id);
      return group!;
    });
  }

  @override
  Future<void> update(ListTasks group) async {
    await _isar.writeTxn(() async {
      await _isar.listTasks.put(group);
    });
  }

  @override
  Future<void> delete(int id) async {
    await _isar.writeTxn(() async {
      await _isar.tasks.filter().groupIdEqualTo(id).deleteAll();
      await _isar.listTasks.delete(id);
    });
  }
}
