import 'dart:convert';

import 'package:isar/isar.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../../domain/repositories/isar_repository.dart';

class IsarDataSource implements IsarRepository {
  final Isar _isar = IsarService.isar;

  @override
  Future<String> export() async {
    final groups = await _isar.listTasks.where().findAll();
    final tasks = await _isar.tasks.where().findAll();
    final data = {
      'groups': groups.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
    };
    return jsonEncode(data);
  }

  @override
  Future<void> import(String jsonEncode) async {
    final json = jsonDecode(jsonEncode);
    List<Map<String, dynamic>> groupsJson = [];
    List<Map<String, dynamic>> tasksJson = [];
    for (var group in json['groups']) {
      groupsJson.add(group);
    }
    for (var task in json['tasks']) {
      tasksJson.add(task);
    }
    await _isar.writeTxn(() async {
      await _isar.listTasks.clear();
      await _isar.listTasks.importJson(groupsJson);
      await _isar.tasks.clear();
      await _isar.tasks.importJson(tasksJson);
    });
    final groups = await _isar.listTasks.where().findAll();
    for (var group in groups) {
      final tasks =
          await _isar.tasks.where().filter().groupIdEqualTo(group.id).findAll();
      group.tasks.addAll(tasks);
      await _isar.writeTxn(() async {
        await group.tasks.save();
      });
    }
  }

  @override
  Future<void> restore() async {
    await _isar.writeTxn(() async {
      await _isar.listTasks.clear();
      await _isar.tasks.clear();
    });
  }
}
