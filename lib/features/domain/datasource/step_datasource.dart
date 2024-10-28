import 'package:tasking/features/domain/domain.dart';

abstract class StepDataSource {
  Future<void> add(int taskId, String value);
  Future<List<StepTask>> getAll(int taskId);
}
