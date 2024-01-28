import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  int groupId;
  String message;
  DateTime? dueDate;
  DateTime? isCompleted;
  DateTime? createAt;

  Task({
    required this.message,
    required this.groupId,
    this.dueDate,
    this.isCompleted,
    this.createAt,
  });

  @override
  String toString() {
    return 'Task(id: $id, groupId: $groupId, message: $message, dueDate: $dueDate,isCompleted: $isCompleted, createAt: $createAt)';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'groupId': groupId,
      'message': message,
      'dueDate': dueDate?.microsecondsSinceEpoch,
      'isCompleted': isCompleted?.microsecondsSinceEpoch,
      'createAt': createAt?.microsecondsSinceEpoch,
    };
  }
}
