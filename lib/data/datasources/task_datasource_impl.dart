import 'package:sqflite/sqflite.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/domain/domain.dart';

class TaskDataSourceImpl implements TaskDataSource {
  final dbHelper = DatabaseHelper();

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
      final now = DateTime.now().toIso8601String();

      final id = await db.rawInsert(
        'INSERT INTO tasks(title, updated_at, created_at, list_id) VALUES(?, ?, ?, ?)',
        [title, now, now, listId],
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
  Future<void> updateReminder(int id, DateTime reminder) async {
    try {
      final Database db = await dbHelper.database;
      final String strReminder = reminder.toIso8601String();
      await db.rawUpdate(
        'UPDATE tasks SET reminder = ? WHERE id = ?',
        [strReminder, id],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Task>> getReminders() async {
    try {
      final Database db = await dbHelper.database;
      final data = await db.rawQuery(
        'SELECT * FROM tasks WHERE reminder IS NOT NULL',
      );
      if (data.isEmpty) return <Task>[];
      return data.map((e) => Task.fromMap(e)).toList();
    } catch (e) {
      return <Task>[];
    }
  }

  @override
  Future<void> deleteReminder(int id) async {
    try {
      final Database db = await dbHelper.database;
      await db.rawUpdate(
        'UPDATE tasks SET reminder = ? WHERE id = ?',
        [null, id],
      );
    } catch (e) {
      rethrow;
    }
  }
}
