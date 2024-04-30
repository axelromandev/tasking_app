import 'package:isar/isar.dart';

part 'subtask.g.dart';

@collection
class SubTask {
  Id id = Isar.autoIncrement;
  final int taskId;
  final String message;
  final bool completed;

  SubTask({
    required this.taskId,
    required this.message,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskId': taskId,
      'message': message,
      'completed': completed,
    };
  }
}
