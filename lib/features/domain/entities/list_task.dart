import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'task.dart';

part 'list_task.g.dart';

@collection
class ListTasks {
  Id id = Isar.autoIncrement;
  String name;
  int position;
  bool isPinned;
  String? password;
  ListIconData? icon;
  int? color;

  final tasks = IsarLinks<Task>();

  ListTasks({
    required this.name,
    required this.position,
    this.isPinned = false,
    this.password,
    this.icon,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'position': position,
      'isPinned': isPinned,
      'password': password,
      'icon': icon?.toMap(),
      'color': color,
    };
  }
}

@embedded
class ListIconData {
  final int? codePoint;
  final String? fontFamily;
  final String? fontPackage;

  const ListIconData({
    this.codePoint,
    this.fontFamily,
    this.fontPackage,
  });

  @override
  String toString() =>
      'GroupIcon(codePoint: $codePoint, fontFamily: $fontFamily, fontPackage: $fontPackage)';

  @ignore
  IconData get iconData {
    return IconData(
      codePoint!,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
    };
  }
}
