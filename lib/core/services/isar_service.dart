import 'dart:convert';
import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/app.dart';
import '../../features/domain/entities/subtask.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [TaskSchema, SubTaskSchema, ListTasksSchema],
        directory: dir.path,
      );
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
    }
  }

  Future<void> tutorial() async {
    // find tutorial in the project
    final tutorial =
        await isar.listTasks.filter().nameEqualTo('Tutorial').findFirst();

    // existing tutorial, skip
    if (tutorial != null) return;

    // not found, create a new one
    try {
      await isar.writeTxn(() async {
        final listId = await isar.listTasks.put(ListTasks(
          name: 'Tutorial',
          color: 0xffff5252,
          position: 0,
          icon: const ListIconData(
            codePoint: 60570,
            fontFamily: 'BoxIcons',
            fontPackage: 'icons_plus',
          ),
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message: 'Tap the left checkbox to check',
          position: 0,
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message: 'Tap the left checkbox to remove the check',
          position: 1,
          completed: true,
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message: 'Tap the right × to delete this task',
          position: 2,
          completed: true,
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message: 'Tap the bottom right + to add a task',
          position: 3,
          completed: true,
        ));

        final taskWithAdditionalId = await isar.tasks.put(Task(
          listId: listId,
          message: 'Tap to edit this task',
          note: 'You can write notes here',
          position: 4,
          completed: true,
        ));

        // add subtask
        await isar.subTasks.put(SubTask(
          taskId: taskWithAdditionalId,
          message: 'You can add subtasks here',
          position: 0,
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message: 'Tap the upper right ⁝ to edit or delete this list',
          position: 5,
          completed: true,
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message:
              'There are other easy-to-use features, so please try them out!',
          position: 6,
          completed: true,
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message:
              'That´s it for the tutorial. I hope this app will be useful to you',
          position: 7,
          completed: true,
        ));

        await isar.tasks.put(Task(
          listId: listId,
          message: 'Thank you for using this app!',
          position: 8,
          completed: true,
        ));
      });
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
      rethrow;
    }
  }

  Future<String> export() async {
    try {
      final groups = await isar.listTasks.where().findAll();
      final tasks = await isar.tasks.where().findAll();
      final data = {
        'groups': groups.map((e) => e.toMap()).toList(),
        'tasks': tasks.map((e) => e.toMap()).toList(),
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
      final lists = await isar.listTasks.where().findAll();
      for (var list in lists) {
        final tasks =
            await isar.tasks.where().filter().listIdEqualTo(list.id).findAll();
        list.tasks.addAll(tasks);
        await isar.writeTxn(() async {
          await list.tasks.save();
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
