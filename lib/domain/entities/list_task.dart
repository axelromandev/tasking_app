import 'package:flutter/material.dart';
import 'package:tasking/domain/domain.dart';

class ListTasks {
  ListTasks({
    required this.id,
    required this.title,
    this.password,
    required this.colorValue,
    this.pinned = false,
    this.archived = false,
    required this.createdAt,
  });

  factory ListTasks.fromMap(Map<String, dynamic> map) {
    return ListTasks(
      id: map['id'] as int,
      title: map['title'] as String,
      password: map['password'] as String?,
      colorValue: map['color'] as int,
      pinned: map['pinned'] == 1,
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
  final String? password;
  final int colorValue;
  final bool pinned;
  final bool archived;
  final DateTime createdAt;

  List<Task> tasks = <Task>[];

  ListTasks copyWith({
    int? id,
    String? title,
    String? password,
    int? color,
    bool? pinned,
    bool? archived,
    DateTime? createdAt,
    List<Task>? tasks,
  }) {
    return ListTasks(
      id: id ?? this.id,
      title: title ?? this.title,
      password: password ?? this.password,
      colorValue: color ?? colorValue,
      pinned: pinned ?? this.pinned,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
    )..tasks = tasks ?? this.tasks;
  }
}
