import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/features/domain/domain.dart';

class ListTasks {
  ListTasks({
    required this.id,
    required this.title,
    required this.icon,
    this.showCompleted = false,
    this.archived = false,
    required this.createdAt,
  });

  factory ListTasks.fromMap(Map<String, dynamic> map) {
    return ListTasks(
      id: map['id'] as int,
      title: map['title'] as String,
      icon: IconDataUtils.decode(map['icon_json'] as String),
      showCompleted: (map['is_show_completed'] as int) == 1,
      archived: (map['is_archived'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  ListTasks.empty()
      : this(
          id: 0,
          title: '',
          icon: IconsaxOutline.folder,
          createdAt: DateTime.now(),
        );

  final int id;
  final String title;
  final IconData icon;
  final bool showCompleted;
  final bool archived;
  final DateTime createdAt;

  List<Task> tasks = <Task>[];
}
