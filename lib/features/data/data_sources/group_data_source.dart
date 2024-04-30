import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../../domain/entities/subtask.dart';

abstract interface class IListTasksDataSource {
  Future<List<ListTasks>> fetchAll();
  Future<ListTasks?> get(int id);
  Future<ListTasks> add(String name, IconData icon);
  Future<void> update(ListTasks group);
  Future<void> delete(int id);
}

class ListTasksDataSource implements IListTasksDataSource {
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
      await _isar.subTasks.filter().taskIdEqualTo(id).deleteAll();
      await _isar.tasks.filter().listIdEqualTo(id).deleteAll();
      await _isar.listTasks.delete(id);
    });
  }
}
