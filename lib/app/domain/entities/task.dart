// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  int groupId;
  String message;
  DateTime? dueDate;
  DateTime? reminder;
  DateTime? isCompleted;
  DateTime? createAt;

  Task({
    required this.message,
    required this.groupId,
    this.dueDate,
    this.reminder,
    this.isCompleted,
    this.createAt,
  });

  @override
  String toString() {
    return 'Task(id: $id, groupId: $groupId, message: $message, dueDate: $dueDate, reminder: $reminder, isCompleted: $isCompleted, createAt: $createAt)';
  }
}
