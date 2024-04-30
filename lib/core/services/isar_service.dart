import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../src/app.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initialize() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [TaskSchema, ListTasksSchema],
        directory: dir.path,
      );
    } catch (e) {
      log('Error', name: 'IsarService', error: e);
    }
  }

  static Future<void> close() async {
    await isar.close();
  }
}
