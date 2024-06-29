import 'package:sqflite/sqflite.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';

abstract interface class ITaskDataSource {
  Future<Task> get(int id);
  Future<List<Task>> getByListId(int id);
  Future<Task> add(int listId, String title);
  Future<void> updateCompleted(int id, bool completed);
  Future<void> updateTitle(int id, String title);
  Future<void> updateNote(int id, String note);
  Future<void> delete(int id);
  Future<void> clearComplete(int listId);
  Future<void> changeList(int taskId, int newListId);
}

class TaskDataSource implements ITaskDataSource {
  final dbHelper = DatabaseHelper();

  @override
  Future<Task> get(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getByListId(int id) async {
    try {
      final Database db = await dbHelper.database;
      final data = await db.rawQuery(
        'SELECT * FROM tasks WHERE list_id = ?',
        [id],
      );
      if (data.isEmpty) return <Task>[];
      return data.map((e) => Task.fromMap(e)).toList();
    } catch (e) {
      return <Task>[];
    }
  }

  @override
  Future<Task> add(int listId, String title) async {
    try {
      final Database db = await dbHelper.database;
      final id = await db.rawInsert(
        'INSERT INTO tasks(title, list_id) VALUES(?, ?)',
        [title, listId],
      );
      final data = await db.rawQuery(
        'SELECT * FROM tasks WHERE id = ?',
        [id],
      );
      return Task.fromMap(data.first);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      final Database db = await dbHelper.database;
      await db.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCompleted(int id, bool completed) async {
    try {
      final Database db = await dbHelper.database;
      final int value = completed ? 1 : 0;
      final String now = DateTime.now().toIso8601String();
      await db.rawUpdate(
        'UPDATE tasks SET completed = ?, updated_at = ? WHERE id = ?',
        [value, now, id],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateNote(int id, String note) async {
    try {
      final Database db = await dbHelper.database;
      final String now = DateTime.now().toIso8601String();
      await db.rawUpdate(
        'UPDATE tasks SET note = ?, updated_at = ? WHERE id = ?',
        [note, now, id],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTitle(int id, String title) async {
    try {
      final Database db = await dbHelper.database;
      final String now = DateTime.now().toIso8601String();
      await db.rawUpdate(
        'UPDATE tasks SET title = ?, updated_at = ? WHERE id = ?',
        [title, now, id],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearComplete(int listId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> changeList(int taskId, int newListId) async {
    throw UnimplementedError();
  }
}
