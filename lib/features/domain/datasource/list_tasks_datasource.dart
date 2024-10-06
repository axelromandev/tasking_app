import 'package:tasking/features/domain/domain.dart';

abstract class ListTasksDataSource {
  Future<List<ListTasks>> getAll();
  Future<ListTasks> get(int id);
  Future<ListTasks> add(ListTasks list);
  Future<void> delete(int id);
  Future<void> update(ListTasks list);
  Future<void> updateArchived(int id, bool archived);
}
