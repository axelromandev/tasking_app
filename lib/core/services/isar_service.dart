import 'dart:convert';
import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/app.dart';
import '../../generated/strings.g.dart';

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

  Future<bool> tutorial() async {
    // find tutorial in the project
    final tutorial =
        await isar.listTasks.filter().nameEqualTo('Tutorial').findFirst();

    // existing tutorial, skip
    if (tutorial != null) return false;

    // not found, create a new one
    try {
      await isar.writeTxn(() async {
        final list1 = ListTasks(
          name: 'Tutorial',
          color: 0xffffc107,
          position: 0,
          icon: const ListIconData(
            codePoint: 59830,
            fontFamily: 'BoxIcons',
            fontPackage: 'icons_plus',
          ),
        );

        final listId = await isar.listTasks.put(list1);

        final task1 = Task(
          listId: listId,
          message: S.tutorial_task_1,
          position: 0,
        );
        final task2 = Task(
          listId: listId,
          message: S.tutorial_task_2,
          position: 1,
          completed: true,
        );
        final task3 = Task(
          listId: listId,
          message: S.tutorial_task_3,
          position: 2,
          completed: true,
        );
        final task4 = Task(
          listId: listId,
          message: S.tutorial_task_4,
          position: 3,
          completed: true,
        );
        final task5 = Task(
          listId: listId,
          message: S.tutorial_task_5,
          note: S.tutorial_task_5_note,
          position: 4,
          completed: true,
        );
        final task6 = Task(
          listId: listId,
          message: S.tutorial_task_6,
          position: 5,
          completed: true,
        );
        final task7 = Task(
          listId: listId,
          message: S.tutorial_task_7,
          position: 6,
          completed: true,
        );
        final task8 = Task(
          listId: listId,
          message: S.tutorial_task_8,
          position: 7,
          completed: true,
        );
        final task9 = Task(
          listId: listId,
          message: S.tutorial_task_9,
          position: 8,
          completed: true,
        );
        final task10 = Task(
          listId: listId,
          message: S.tutorial_task_10,
          position: 9,
          completed: true,
        );

        // save all tasks
        await isar.tasks.put(task1);
        await isar.tasks.put(task2);
        await isar.tasks.put(task3);
        await isar.tasks.put(task4);
        final taskWithAdditionalId = await isar.tasks.put(task5);
        await isar.tasks.put(task6);
        await isar.tasks.put(task7);
        await isar.tasks.put(task8);
        await isar.tasks.put(task9);
        await isar.tasks.put(task10);

        // link tasks to the list
        list1.tasks.addAll([
          task1,
          task2,
          task3,
          task4,
          task5,
          task6,
          task7,
          task8,
          task9,
          task10,
        ]);
        await list1.tasks.save();

        // add subtasks to task4
        final subtask1 = SubTask(
          taskId: taskWithAdditionalId,
          message: S.tutorial_task_5_subtask,
        );
        await isar.subTasks.put(subtask1);
        task5.subtasks.add(subtask1);
        await task5.subtasks.save();
      });

      return true;
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
      return false;
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
      final json = jsonDecode(jsonEncode) as Map<String, dynamic>;
      final List<Map<String, dynamic>> groupsJson = [];
      final List<Map<String, dynamic>> tasksJson = [];
      for (final group in json['groups'] as List<Map<String, dynamic>>) {
        groupsJson.add(group);
      }
      for (final task in json['tasks'] as List<Map<String, dynamic>>) {
        tasksJson.add(task);
      }
      await isar.writeTxn(() async {
        await isar.listTasks.clear();
        await isar.listTasks.importJson(groupsJson);
        await isar.tasks.clear();
        await isar.tasks.importJson(tasksJson);
      });
      final lists = await isar.listTasks.where().findAll();
      for (final list in lists) {
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
        for (final collection in collections) {
          await collection.clear();
        }
      });
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
      rethrow;
    }
  }

  Future<void> clear() async {
    try {
      await isar.writeTxn(() async {
        await isar.clear();
      });
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
      rethrow;
    }
  }
}
