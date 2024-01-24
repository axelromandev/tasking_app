import 'package:isar/isar.dart';
import 'package:tasking/app/domain/entities/group.dart';

import '../../../core/core.dart';
import '../repositories/group_repository.dart';

class GroupDataSource implements GroupRepository {
  final Isar _isar = IsarService.isar;

  @override
  Future<List<GroupTasks>> fetchAll() async {
    return await _isar.groupTasks.where().findAll();
  }

  @override
  Future<GroupTasks?> get(int id) async {
    return await _isar.groupTasks.get(id);
  }

  @override
  Future<GroupTasks> add(String name) async {
    return await _isar.writeTxn(() async {
      final id = await _isar.groupTasks.put(GroupTasks(name: name));
      final group = await _isar.groupTasks.get(id);
      return group!;
    });
  }
}
