import 'package:isar/isar.dart';

part 'subtask.g.dart';

@collection
class SubTask {
  SubTask({
    required this.taskId,
    required this.message,
    this.completed = false,
  });

  Id id = Isar.autoIncrement;
  int taskId;
  String message;
  bool completed;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskId': taskId,
      'message': message,
      'completed': completed,
    };
  }
}
