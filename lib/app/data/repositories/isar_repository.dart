abstract interface class IsarRepository {
  Future<String> export();
  Future<void> import(String jsonEncode);
  Future<void> restore();
}
