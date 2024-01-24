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
}
