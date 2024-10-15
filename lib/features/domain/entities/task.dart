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
          ? DateTime.fromMillisecondsSinceEpoch(map['dateline'] as int)
          : null,
      reminder: map['reminder'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reminder'] as int)
          : null,
      notes: map['notes'] as String? ?? '',
      completedAt: map['completed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['completed_at'] as int)
          : null,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'list_id': listId,
      'title': title,
      'dateline': dateline?.millisecondsSinceEpoch,
      'reminder': reminder?.millisecondsSinceEpoch,
      'notes': notes,
      'completed_at': completedAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
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
