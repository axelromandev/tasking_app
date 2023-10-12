import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.isCompleted,
  });
}
