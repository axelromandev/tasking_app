import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  String message;
  DateTime? dueDate;
  DateTime? reminder;
  DateTime? isCompleted;
  DateTime? createAt;

  Task({
    required this.message,
    this.dueDate,
    this.reminder,
    this.isCompleted,
    required this.createAt,
  });
}
