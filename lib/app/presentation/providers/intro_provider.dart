import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../widgets/permission_notification_modal.dart';

final introProvider = StateNotifierProvider.autoDispose<_Notifier, void>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<void> {
  _Notifier() : super(null);

  final _pref = SharedPrefsService();

  void onNext(BuildContext context) async {
    await Permission.notification.status.then((value) async {
      if (value.isDenied) {
        await showModalBottomSheet<bool>(
          context: context,
          isDismissible: false,
          enableDrag: false,
          builder: (_) => const PermissionNotificationModal(),
        ).then((_) async {
          await Permission.notification.request().then((_) async {
            await _finish(context);
          });
        });
      } else {
        await _finish(context);
      }
    });
  }

  Future<void> _finish(BuildContext context) async {
    await _pref.setKeyValue<bool>(Keys.isFirstTime, false).then((value) {
      context.go(RoutesPath.home);
    });
  }
}
