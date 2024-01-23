import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final notificationsProvider = StateNotifierProvider<_Notifier, bool>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<bool> {
  _Notifier() : super(false) {
    checking();
  }

  void checking() async {
    final status = await Permission.notification.status;
    state = status.isGranted;
  }

  Future<PermissionStatus> onRequest() async {
    final value = await Permission.notification.request();
    state = value.isGranted;
    return value;
  }

  void change(bool value) {
    state = value;
  }
}
