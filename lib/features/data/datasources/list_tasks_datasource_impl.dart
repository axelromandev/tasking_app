import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';

class ListTasksDataSourceImpl implements ListTasksDataSource {
  final dbHelper = DatabaseHelper();

  @override
  Future<List<ListTasks>> getAll() async {
    try {
      final Database db = await dbHelper.database;
      final data = await db.rawQuery('SELECT * FROM lists');
      return data.map((e) => ListTasks.fromMap(e)).toList();
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.getAll');
      return [];
    }
  }

  @override
  Future<ListTasks> get(int id) async {
    try {
      final Database db = await dbHelper.database;
      final data = await db.rawQuery(
        'SELECT * FROM lists WHERE id = ?',
        [id],
      );
      if (data.isEmpty) throw Exception('not found');
      return ListTasks.fromMap(data.first);
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.get');
      rethrow;
    }
  }

  @override
  Future<ListTasks> add(ListTasks list) async {
    try {
      final Database db = await dbHelper.database;
      final id = await db.insert(
        'lists',
        list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      final data = await db.query(
        'lists',
        where: 'id = ?',
        whereArgs: [id],
      );
      return ListTasks.fromMap(data.first);
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.add');
      rethrow;
    }
  }

  @override
  Future<void> update(ListTasks list) async {
    try {
      final Database db = await dbHelper.database;
      await db.update(
        'lists',
        list.toMap(),
        where: 'id = ?',
        whereArgs: [list.id],
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.update');
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      final Database db = await dbHelper.database;
      await db.rawDelete(
        'DELETE FROM lists WHERE id = ?',
        [id],
      );
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.delete');
      rethrow;
    }
  }

  @override
  Future<void> updateArchived(int id, bool archived) async {
    try {
      final Database db = await dbHelper.database;
      final int value = archived ? 1 : 0;
      await db.rawUpdate(
        'UPDATE lists SET archived = ? WHERE id = ?',
        [value, id],
      );
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.updateArchived');
      rethrow;
    }
  }
}
