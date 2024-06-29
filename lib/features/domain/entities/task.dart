class Task {
  Task({
    required this.id,
    required this.title,
    this.note,
    this.completed = false,
    this.reminder,
    required this.listId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      note: map['note'] as String?,
      completed: map['completed'] == 1,
      reminder: map['reminder'] != null
          ? DateTime.parse(map['reminder'] as String)
          : null,
      listId: map['list_id'] as int,
      updatedAt: DateTime.parse(map['updated_at'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  final int id;
  final String title;
  final String? note;
  final bool completed;
  final DateTime? reminder;
  final int listId;
  final DateTime updatedAt;
  final DateTime createdAt;
}
