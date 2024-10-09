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
      final data = await db.query(
        'tasks',
        where: 'list_id = ?',
        whereArgs: [id],
      );
      if (data.isEmpty) return <Task>[];
      return data.map((e) => Task.fromMap(e)).toList();
    } catch (e) {
      return <Task>[];
    }
  }

  @override
  Future<Task> add(Task task) async {
    try {
      final Database db = await dbHelper.database;
      final id = await db.insert(
        'tasks',
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      final data = await db.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
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
      await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
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
      final data = await db.query(
        'tasks',
        where: 'reminder IS NOT NULL',
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
      await db.update(
        'tasks',
        {'reminder': null},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleCompleted(int id) async {
    try {
      final Database db = await dbHelper.database;
      final task = await get(id);
      final newTask = task.toggleCompleted();
      await db.update(
        'tasks',
        newTask.toMap(),
        where: 'id = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } catch (e) {
      rethrow;
    }
  }
}
