// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'task.dart';

part 'group.g.dart';

@collection
class GroupTasks {
  Id id = Isar.autoIncrement;
  String name;
  GroupIcon? icon;

  final tasks = IsarLinks<Task>();

  GroupTasks({
    required this.name,
    this.icon,
  });

  @override
  String toString() => 'GroupTasks(id: $id, name: $name, icon: $icon)';
}

@embedded
class GroupIcon {
  final int? codePoint;
  final String? fontFamily;
  final String? fontPackage;

  const GroupIcon({
    this.codePoint,
    this.fontFamily,
    this.fontPackage,
  });

  @override
  String toString() =>
      'GroupIcon(codePoint: $codePoint, fontFamily: $fontFamily, fontPackage: $fontPackage)';

  IconData get iconData {
    return IconData(
      codePoint!,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }
}
