import 'package:tasking/features/domain/domain.dart';

abstract class StepRepository {
  Future<void> add(int taskId, String value);
  Future<List<StepTask>> getAll(int taskId);
  Future<void> delete(int stepId);
  Future<void> update(int stepId, Map<String, dynamic> data);
}
