class StepTask {
  StepTask({
    required this.id,
    required this.taskId,
    required this.title,
    this.completedAt,
    this.createdAt,
  });

  factory StepTask.fromMap(Map<String, dynamic> map) {
    return StepTask(
      id: map['id'] as int,
      taskId: map['task_id'] as int,
      title: map['title'] as String,
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'] as String)
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  final int id;
  final int taskId;
  final String title;
  final DateTime? completedAt;
  final DateTime? createdAt;
}
