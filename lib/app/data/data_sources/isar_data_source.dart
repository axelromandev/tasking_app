import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:tasking/app/domain/domain.dart';

import '../../../core/core.dart';
import '../repositories/isar_repository.dart';

class IsarDataSource implements IsarRepository {
  final Isar _isar = IsarService.isar;

  @override
  Future<String> export() async {
    final groups = await _isar.groupTasks.where().findAll();
    final tasks = await _isar.tasks.where().findAll();
    final data = {
      'groups': groups.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
    };
    return jsonEncode(data);
  }

  @override
  Future<void> import(Map<String, dynamic> data) async {
    //TODO: Implementar la funcionalidad de importar desde el dispositivo

    // await _isar.writeTxn(() async {
    //   await _isar.groupTasks.clear();
    //   await _isar.tasks.clear();
    //   final groups = data['groups'] as List<Map>;
    // });
  }

  @override
  Future<void> restore() async {
    await _isar.writeTxn(() async {
      await _isar.groupTasks.clear();
      await _isar.tasks.clear();
    });
  }
}
