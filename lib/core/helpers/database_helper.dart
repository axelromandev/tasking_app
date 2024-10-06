import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasking/i18n/i18n.dart';

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
          CREATE TABLE IF NOT EXISTS "lists" (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT,
            "title" TEXT NOT NULL,
            "icon_json" TEXT NOT NULL,
            "is_show_completed" INTEGER DEFAULT 0,
            "created_at" TEXT DEFAULT (datetime('now'))
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS "tasks" (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT,
            "list_id" INTEGER,
            "title" TEXT NOT NULL,
            "dateline" TEXT,
            "reminder" TEXT,
            "notes" TEXT,
            "completed_at" TEXT,
            "updated_at" TEXT DEFAULT (datetime('now')),
            "created_at" TEXT DEFAULT (datetime('now')),
            FOREIGN KEY ("list_id") REFERENCES "lists" ("id")
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS "steps" (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT,
            "task_id" INTEGER,
            "title" TEXT NOT NULL,
            "completed_at" TEXT,
            "created_at" TEXT DEFAULT (datetime('now')),
            FOREIGN KEY ("task_id") REFERENCES "tasks" ("id")
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
    await db.transaction((txn) async {
      final int listId = await txn.insert(
        'lists',
        {
          'title': 'Tutorial',
          'icon_json':
              '{"codePoint":60094,"fontFamily":"IconsaxOutline","fontPackage":"ficonsax"}',
          'is_show_completed': 1,
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      final List<Map<String, dynamic>> tasksMap = [
        {
          'title': S.pages.intro.tutorial.task1,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task2,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task3,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task4,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task5,
          'notes': S.pages.intro.tutorial.task5note,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task6,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task7,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task8,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
        {
          'title': S.pages.intro.tutorial.task9,
          'updated_at': DateTime.now().toIso8601String(),
          'created_at': DateTime.now().toIso8601String(),
          'list_id': listId,
        },
      ];

      for (final dataMap in tasksMap) {
        await txn.insert(
          'tasks',
          dataMap,
          conflictAlgorithm: ConflictAlgorithm.abort,
        );
      }
    });
  }

  Future<void> restore() async {
    final Database db = await database;

    // Desactivar claves foráneas temporalmente
    await db.execute('PRAGMA foreign_keys = OFF;');

    // Borrar datos de todas las tablas
    await db.transaction((txn) async {
      await txn.delete('steps');
      await txn.delete('tasks');
      await txn.delete('lists');
    });

    // Restablecer el contador AUTOINCREMENT para cada tabla
    await db.execute("DELETE FROM sqlite_sequence WHERE name='steps';");
    await db.execute("DELETE FROM sqlite_sequence WHERE name='tasks';");
    await db.execute("DELETE FROM sqlite_sequence WHERE name='lists';");

    // Reactivar claves foráneas
    await db.execute('PRAGMA foreign_keys = ON;');

    await _tutorialListQuery(db);
  }
}
