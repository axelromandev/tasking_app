import 'package:flutter_riverpod/flutter_riverpod.dart';

final backupProvider =
    StateNotifierProvider.autoDispose<_Notifier, void>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<void> {
  _Notifier() : super(null);

  void exportToDevice() async {
    //TODO: Implementar la funcionalidad de exportar en el dispositivo

    final now = DateTime.now();

    print(now);
  }

  void importFromDevice() async {
    //TODO: Implementar la funcionalidad de importar desde el dispositivo
  }

  void exportToExcel() async {
    //TODO: Implementar la funcionalidad de exportar a Excel
  }
}
