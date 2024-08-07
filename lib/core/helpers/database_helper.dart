import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../i18n/generated/translations.g.dart';

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
              pinned INTEGER DEFAULT 0,
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
              reminder DATETIME,
              updated_at DATETIME NOT NULL,
              created_at DATETIME NOT NULL,
              list_id INTEGER NOT NULL,
              FOREIGN KEY (list_id) REFERENCES lists(id) ON DELETE CASCADE
            );
        ''');
      },
    );
  }

  Future<void> insertTutorialList() async {
    final Database db = await database;
    await _tutorialListQuery(db);
  }

  Future<void> _tutorialListQuery(Database db) async {
    final String now = DateTime.now().toIso8601String();
    await db.transaction((txn) async {
      final int listId = await txn.rawInsert(
        "INSERT INTO lists (title, color) VALUES ('Tutorial', 4294951175)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task1}', '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task2}', 1, '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task3}', 1, '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task4}', 1, '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, note, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task5}', 1, '${S.pages.intro.tutorial.task5note}', '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task6}', 1, '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task7}', 1, '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task8}', 1, '$now', '$now', $listId)",
      );
      await txn.rawInsert(
        "INSERT INTO tasks (title, completed, updated_at, created_at, list_id) VALUES ('${S.pages.intro.tutorial.task9}', 1, '$now', '$now', $listId)",
      );
    });
  }

  Future<void> restore() async {
    final Database db = await database;
    await db.transaction((txn) async {
      await txn.rawDelete('DELETE FROM tasks');
      await txn.rawDelete('DELETE FROM lists');
    });
    await _tutorialListQuery(db);
  }
}
