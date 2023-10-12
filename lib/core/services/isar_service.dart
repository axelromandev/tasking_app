import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/app.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskSchema],
      directory: dir.path,
    );
  }

  static Future<void> close() async {
    await isar.close();
  }
}
