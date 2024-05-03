import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../../domain/entities/subtask.dart';

abstract interface class IListTasksDataSource {
  Future<List<ListTasks>> fetchAll();
  Future<ListTasks?> get(int id);
  Future<ListTasks> add(String name, Color color, [IconData? icon]);
  Future<void> delete(int id);
  Future<void> update(ListTasks list);
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
  Future<ListTasks> add(String name, Color color, [IconData? icon]) async {
    return await _isar.writeTxn(() async {
      final groups = await _isar.listTasks.where().findAll();
      int lastPosition = groups.isEmpty ? 0 : groups.last.position;
      final id = await _isar.listTasks.put(ListTasks(
        name: name,
        position: (lastPosition += 1),
        color: color.value,
        icon: ListIconData.fromIcon(icon),
      ));
      final list = await _isar.listTasks.get(id);
      return list!;
    });
  }

  @override
  Future<void> update(ListTasks list) async {
    await _isar.writeTxn(() async {
      await _isar.listTasks.put(list);
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
