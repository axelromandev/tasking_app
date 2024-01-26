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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon?.toJson(),
    };
  }
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

  @ignore
  IconData get iconData {
    return IconData(
      codePoint!,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code_point': codePoint,
      'font_family': fontFamily,
      'font_package': fontPackage,
    };
  }
}
