import 'dart:convert';
import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/app.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [TaskSchema, ListTasksSchema],
        directory: dir.path,
      );
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
    }
  }

  Future<String> export() async {
    try {
      final groups = await isar.listTasks.where().findAll();
      final tasks = await isar.tasks.where().findAll();
      final data = {
        'groups': groups.map((e) => e.toJson()).toList(),
        'tasks': tasks.map((e) => e.toJson()).toList(),
      };
      return jsonEncode(data);
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
      rethrow;
    }
  }

  Future<void> import(String jsonEncode) async {
    try {
      final json = jsonDecode(jsonEncode);
      List<Map<String, dynamic>> groupsJson = [];
      List<Map<String, dynamic>> tasksJson = [];
      for (var group in json['groups']) {
        groupsJson.add(group);
      }
      for (var task in json['tasks']) {
        tasksJson.add(task);
      }
      await isar.writeTxn(() async {
        await isar.listTasks.clear();
        await isar.listTasks.importJson(groupsJson);
        await isar.tasks.clear();
        await isar.tasks.importJson(tasksJson);
      });
      final groups = await isar.listTasks.where().findAll();
      for (var group in groups) {
        final tasks = await isar.tasks
            .where()
            .filter()
            .groupIdEqualTo(group.id)
            .findAll();
        group.tasks.addAll(tasks);
        await isar.writeTxn(() async {
          await group.tasks.save();
        });
      }
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
      rethrow;
    }
  }

  Future<void> restore(List<IsarCollection> collections) async {
    try {
      await isar.writeTxn(() async {
        for (var collection in collections) {
          await collection.clear();
        }
      });
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
      rethrow;
    }
  }
}
