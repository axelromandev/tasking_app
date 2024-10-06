class Task {
  Task({
    required this.id,
    required this.listId,
    required this.title,
    this.dateline,
    this.reminder,
    this.notes = '',
    this.completedAt,
    required this.updatedAt,
    required this.createdAt,
  });

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
      updatedAt: DateTime.parse(map['updated_at'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'list_id': listId,
      'title': title,
      'dateline': dateline?.toIso8601String(),
      'reminder': reminder?.toIso8601String(),
      'notes': notes,
      'completed_at': completedAt?.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
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
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Task toggleCompleted() {
    return Task(
      id: id,
      listId: listId,
      title: title,
      dateline: dateline,
      reminder: reminder,
      notes: notes,
      completedAt: (completedAt == null) ? DateTime.now() : null,
      updatedAt: DateTime.now(),
      createdAt: createdAt,
    );
  }

  final int id;
  final int listId;
  final String title;
  final DateTime? dateline;
  final DateTime? reminder;
  final String notes;
  final DateTime? completedAt;
  final DateTime updatedAt;
  final DateTime createdAt;
}
