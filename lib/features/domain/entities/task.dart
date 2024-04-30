import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  int groupId;
  String message;
  DueDate? dueDate;
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
      'dueDate': dueDate?.toJson(),
      'isCompleted': isCompleted?.microsecondsSinceEpoch,
      'createAt': createAt?.microsecondsSinceEpoch,
    };
  }
}

@embedded
class DueDate {
  final DateTime? date;
  final bool isReminder;

  DueDate({
    this.date,
    this.isReminder = false,
  });

  DueDate copyWith({
    DateTime? date,
    bool? isReminder,
  }) {
    return DueDate(
      date: date ?? this.date,
      isReminder: isReminder ?? this.isReminder,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date?.microsecondsSinceEpoch,
      'isReminder': isReminder,
    };
  }
}
