import 'package:flutter/material.dart';
import 'package:tasking/features/domain/domain.dart';

class ListTasks {
  ListTasks({
    required this.id,
    required this.title,
    required this.colorValue,
    this.archived = false,
    required this.createdAt,
  });

  factory ListTasks.fromMap(Map<String, dynamic> map) {
    return ListTasks(
      id: map['id'] as int,
      title: map['title'] as String,
      colorValue: map['colorValue'] as int,
      archived: map['archived'] == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  ListTasks.empty()
      : this(
          id: 0,
          title: '',
          colorValue: 0xffffc107,
          createdAt: DateTime.now(),
        );

  Color get color => Color(colorValue);

  final int id;
  final String title;
  final int colorValue;
  final bool archived;
  final DateTime createdAt;

  List<Task> tasks = <Task>[];
}
