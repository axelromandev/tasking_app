abstract interface class IsarRepository {
  Future<String> export();
  Future<void> import(Map<String, dynamic> data);
  Future<void> restore();
}
