import 'package:isar/isar.dart';

part 'subtask.g.dart';

@collection
class SubTask {
  Id id = Isar.autoIncrement;
  final int taskId;
  final String message;
  final int position;
  final bool completed;

  SubTask({
    required this.taskId,
    required this.message,
    required this.position,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskId': taskId,
      'message': message,
      'position': position,
      'completed': completed,
    };
  }
}
