import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'task.dart';

part 'list_task.g.dart';

@collection
class ListTasks {
  Id id = Isar.autoIncrement;
  String name;
  String? password;
  ListIconData? icon;

  final tasks = IsarLinks<Task>();

  ListTasks({
    required this.name,
    this.password,
    this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'icon': icon?.toMap(),
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
