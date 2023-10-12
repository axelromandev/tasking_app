import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  final String message;
  final DateTime? dueDate;
  bool isCompleted;

  Task({
    required this.message,
    required this.dueDate,
    required this.isCompleted,
  });
}
