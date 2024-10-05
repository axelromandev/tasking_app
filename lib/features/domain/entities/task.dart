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
