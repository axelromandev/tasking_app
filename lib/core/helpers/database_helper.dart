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
            "is_default" BOOLEAN DEFAULT false,
            "is_show_completed" BOOLEAN DEFAULT false,
            "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS "tasks" (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT,
            "list_id" INTEGER,
            "title" TEXT NOT NULL,
            "dateline" TIMESTAMP,
            "reminder" TIMESTAMP,
            "notes" TEXT,
            "completed_at" TIMESTAMP,
            "is_important" BOOLEAN DEFAULT false,
            "updated_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY ("list_id") REFERENCES "lists" ("id")
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS "steps" (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT,
            "task_id" INTEGER,
            "title" TEXT NOT NULL,
            "completed_at" TIMESTAMP,
            "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
      await txn.insert(
        'lists',
        {
          'title': S.features.tasks.title,
          'is_default': 1,
          'icon_json':
              '{"codePoint":59843,"fontFamily":"IconsaxOutline","fontPackage":"ficonsax"}',
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      final int listId = await txn.insert(
        'lists',
        {
          'title': S.features.intro.tutorial.title,
          'is_show_completed': 1,
          'icon_json':
              '{"codePoint":60094,"fontFamily":"IconsaxOutline","fontPackage":"ficonsax"}',
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      final List<Map<String, dynamic>> tasksMap = [
        {
          'title': S.features.intro.tutorial.task1,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task2,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task3,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task4,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task5,
          'notes': S.features.intro.tutorial.task5note,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task6,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task7,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task8,
          'list_id': listId,
        },
        {
          'title': S.features.intro.tutorial.task9,
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
