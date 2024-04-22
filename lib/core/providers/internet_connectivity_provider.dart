import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final internetConnectivityProvider =
    StateNotifierProvider<_Notifier, bool>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<bool> {
  _Notifier() : super(true) {
    _checkingStatus();
  }

  InternetConnection internetConnection = InternetConnection();

  Future<void> _checkingStatus() async {
    print('_checkingStatus');
    internetConnection.onStatusChange.listen((status) {
      state = (InternetStatus.connected == status);
    });
  }
}
