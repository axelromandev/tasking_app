import '../../data/data.dart';

abstract interface class ILocalRepository {
  Future<String> export();
  Future<void> import(String jsonEncode);
  Future<void> restore();
}

class LocalRepository extends ILocalRepository {
  final ILocalDataSource _dataSource = LocalDataSource();

  @override
  Future<String> export() {
    return _dataSource.export();
  }

  @override
  Future<void> import(String jsonEncode) {
    return _dataSource.import(jsonEncode);
  }

  @override
  Future<void> restore() {
    return _dataSource.restore();
  }
}
