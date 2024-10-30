import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';

class StepDataSourceImpl implements StepDataSource {
  final dbHelper = DatabaseHelper();

  @override
  Future<void> add(int taskId, String value) async {
    try {
      final db = await dbHelper.database;
      await db.insert(
        'steps',
        {
          'task_id': taskId,
          'title': value,
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } catch (e) {
      log(e.toString(), name: 'StepDataSourceImpl.add');
    }
  }

  @override
  Future<List<StepTask>> getAll(int taskId) async {
    try {
      final db = await dbHelper.database;
      final data = await db.query(
        'steps',
        where: 'task_id = ?',
        whereArgs: [taskId],
      );
      return data.map((e) => StepTask.fromMap(e)).toList();
    } catch (e) {
      log(e.toString(), name: 'StepDataSourceImpl.getAll');
      return [];
    }
  }

  @override
  Future<void> delete(int stepId) async {
    try {
      final db = await dbHelper.database;
      await db.delete(
        'steps',
        where: 'id = ?',
        whereArgs: [stepId],
      );
    } catch (e) {
      log(e.toString(), name: 'StepDataSourceImpl.delete');
    }
  }

  @override
  Future<void> update(int stepId, Map<String, dynamic> data) async {
    try {
      final db = await dbHelper.database;
      await db.update(
        'steps',
        data,
        where: 'id = ?',
        whereArgs: [stepId],
      );
    } catch (e) {
      log(e.toString(), name: 'StepDataSourceImpl.update');
    }
  }
}
