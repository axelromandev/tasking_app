import 'package:isar/isar.dart';

import 'subtask.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  final int listId;
  final String message;
  final int position;
  final String? note;
  final DateTime? reminder;
  final bool completed;
  final DateTime? createAt;

  final subtasks = IsarLinks<SubTask>();

  bool get hasNote => note != null && note!.isNotEmpty;

  Task({
    required this.listId,
    required this.message,
    required this.position,
    this.note,
    this.reminder,
    this.completed = false,
    this.createAt,
  });

  Task copyWith({
    int? listId,
    String? message,
    int? position,
    String? note,
    DateTime? reminder,
    bool? completed,
    DateTime? createAt,
  }) {
    return Task(
      listId: listId ?? this.listId,
      message: message ?? this.message,
      position: position ?? this.position,
      note: note ?? this.note,
      reminder: reminder ?? this.reminder,
      completed: completed ?? this.completed,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'listId': listId,
      'message': message,
      'position': position,
      'note': note,
      'reminder': reminder?.millisecondsSinceEpoch,
      'completed': completed,
      'createAt': createAt?.millisecondsSinceEpoch,
    };
  }
}
