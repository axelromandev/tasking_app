import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';

class Task {
  Task({
    required this.id,
    required this.listId,
    required this.title,
    this.dateline,
    this.reminder,
    this.notes = '',
    this.completedAt,
    this.isImportant = false,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Task.create({
    required int listId,
    required String title,
    String notes = '',
    DateTime? dateline,
    DateTime? reminder,
  }) {
    return Task(
      id: 0,
      listId: listId,
      title: title,
      dateline: dateline,
      reminder: reminder,
      notes: notes,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      listId: map['list_id'] as int,
      title: map['title'] as String,
      dateline: map['dateline'] != null
          ? DateTime.parse(map['dateline'] as String)
          : null,
      reminder: map['reminder'] != null
          ? DateTime.parse(map['reminder'] as String)
          : null,
      notes: map['notes'] as String? ?? '',
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'] as String)
          : null,
      isImportant: map['is_important'] == 1,
      updatedAt: DateTime.parse(map['updated_at'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  final int id;
  final int listId;
  final String title;
  final DateTime? dateline;
  final DateTime? reminder;
  final String notes;
  final DateTime? completedAt;
  final bool isImportant;
  final DateTime updatedAt;
  final DateTime createdAt;

  List<StepTask> steps = [];

  Map<String, dynamic> toMap() {
    return {
      'list_id': listId,
      'title': title,
      'dateline': dateline?.toDatabaseFormat(),
      'reminder': reminder?.toDatabaseFormat(),
      'notes': notes,
      'completed_at': completedAt?.toDatabaseFormat(),
      'is_important': isImportant ? 1 : 0,
      'updated_at': updatedAt.toDatabaseFormat(),
      'created_at': createdAt.toDatabaseFormat(),
    };
  }

  Task copyWith({
    int? id,
    int? listId,
    String? title,
    DateTime? dateline,
    DateTime? reminder,
    String? notes,
    DateTime? completedAt,
    bool? isImportant,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      title: title ?? this.title,
      dateline: dateline ?? this.dateline,
      reminder: reminder ?? this.reminder,
      notes: notes ?? this.notes,
      completedAt: completedAt ?? this.completedAt,
      isImportant: isImportant ?? this.isImportant,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
