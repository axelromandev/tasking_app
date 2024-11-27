import 'dart:developer';

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

  Future<String> _getDatabasesPath() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'tasking.db');
    log('Database 🚀: $path');
    return path;
  }

  Future<Database> initDatabase() async {
    return await openDatabase(
      await _getDatabasesPath(),
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
        await db.insert(
          'lists',
          {
            'title': S.features.tasks.title,
            'is_default': 1,
            'icon_json':
                '{"codePoint":59843,"fontFamily":"IconsaxOutline","fontPackage":"ficonsax"}',
          },
        );
      },
    );
  }
}
