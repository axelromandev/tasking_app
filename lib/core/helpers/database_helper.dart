import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../generated/strings.g.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'tasking.db');
    log(path, name: 'Database Path');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE lists(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              password TEXT,
              color INTEGER NOT NULL,
              archived INTEGER DEFAULT 0,
              created_at DATETIME DEFAULT CURRENT_TIMESTAMP
            );
        ''');
        await db.execute('''
            CREATE TABLE tasks(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              note TEXT,
              completed INTEGER DEFAULT 0,
              pinned INTEGER DEFAULT 0,
              archived INTEGER DEFAULT 0,
              reminder DATETIME,
              update_at DATETIME DEFAULT CURRENT_TIMESTAMP,
              created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
              list_id INTEGER NOT NULL,
              FOREIGN KEY (list_id) REFERENCES lists(id) ON DELETE CASCADE
            );
        ''');
        await db.execute('''
            CREATE TABLE subtasks(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              completed INTEGER DEFAULT 0,
              update_at DATETIME DEFAULT CURRENT_TIMESTAMP,
              task_id INTEGER NOT NULL,
              FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
            );
        ''');
      },
    );
  }

  Future<void> insertTutorialList() async {
    final Database db = await database;
    await db.transaction((txn) async {
      final int listId = await txn.rawInsert(
        "INSERT INTO lists (title, color) VALUES ('Tutorial', 4294951175)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task1}', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task2}', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task3}', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task4}', $listId)",
      );
      final int task5Id = await txn.rawInsert(
        "INSERT INTO tasks (title, note, list_id) VALUES ('${S.pages.intro.tutorial.task5}', '${S.pages.intro.tutorial.task5note}', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO subtasks (title, task_id) VALUES ('${S.pages.intro.tutorial.task5subtask}', $task5Id)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task6}', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task7}', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task8}', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, list_id) VALUES ('${S.pages.intro.tutorial.task9}', $listId)",
      );
    });
  }
}
