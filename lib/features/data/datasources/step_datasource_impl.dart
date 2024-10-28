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
}
