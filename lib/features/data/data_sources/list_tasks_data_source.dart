import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';

abstract interface class IListTasksDataSource {
  Future<List<ListTasks>> getAll();
  Future<ListTasks> get(int id);
  Future<ListTasks> add(String name, Color color);
  Future<void> delete(int id);
  Future<void> update(int id, String title, Color color);
  Future<void> updatePinned(int id, bool pinned);
  Future<void> updateArchived(int id, bool archived);
}

class ListTasksDataSource implements IListTasksDataSource {
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
  Future<ListTasks> add(String title, Color color) async {
    try {
      final Database db = await dbHelper.database;
      final id = await db.rawInsert(
        'INSERT INTO lists(title, color) VALUES(?, ?)',
        [title, color.value],
      );
      final data = await db.rawQuery(
        'SELECT * FROM lists WHERE id = ?',
        [id],
      );
      return ListTasks.fromMap(data.first);
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.add');
      rethrow;
    }
  }

  @override
  Future<void> update(int id, String title, Color color) async {
    try {
      final Database db = await dbHelper.database;
      await db.rawUpdate(
        'UPDATE lists SET title = ?, color = ? WHERE id = ?',
        [title, color.value, id],
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
  Future<void> updatePinned(int id, bool pinned) async {
    try {
      final Database db = await dbHelper.database;
      final int value = pinned ? 1 : 0;
      await db.rawUpdate(
        'UPDATE lists SET pinned = ? WHERE id = ?',
        [value, id],
      );
    } catch (e) {
      log(e.toString(), name: 'ListTasksDataSource.updatePinned');
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
