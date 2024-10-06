import 'package:sqflite/sqflite.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';

class TaskDataSourceImpl implements TaskDataSource {
  final dbHelper = DatabaseHelper();

  @override
  Future<Task> get(int id) async {
    try {
      final Database db = await dbHelper.database;
      final data = await db.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      return Task.fromMap(data.first);
    } catch (e) {
      rethrow;
    }
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
  Future<void> update(Task task) async {
    try {
      final Database db = await dbHelper.database;
      await db.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
        conflictAlgorithm: ConflictAlgorithm.abort,
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
