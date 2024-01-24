// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import 'task.dart';

part 'group.g.dart';

@collection
class GroupTasks {
  Id id = Isar.autoIncrement;
  String name;

  final tasks = IsarLinks<Task>();

  GroupTasks({
    required this.name,
  });

  @override
  String toString() => 'GroupTasks(id: $id, name: $name)';
}
