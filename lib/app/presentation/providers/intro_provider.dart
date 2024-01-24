import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../data/data.dart';
import '../widgets/permission_notification_modal.dart';
import 'notifications_provider.dart';

final introProvider = StateNotifierProvider.autoDispose<_Notifier, void>((ref) {
  final isGranted = ref.read(notificationsProvider);
  final onRequest = ref.read(notificationsProvider.notifier).onRequest;

  return _Notifier(
    isGranted: isGranted,
    onRequest: onRequest,
  );
});

class _Notifier extends StateNotifier<void> {
  final bool isGranted;
  final Future<PermissionStatus> Function() onRequest;

  _Notifier({
    required this.isGranted,
    required this.onRequest,
  }) : super(null);

  final _pref = SharedPrefsService();

  final groupDataSource = GroupDataSource();

  void onNext(BuildContext context) async {
    if (isGranted) {
      await _finish(context);
      return;
    }
    await showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => const PermissionNotificationModal(),
    ).then((_) async {
      await onRequest().then((_) async {
        await _finish(context);
      });
    });
  }

  Future<void> _finish(BuildContext context) async {
    final group = await groupDataSource.add('Personal', BoxIcons.bx_user);
    await _pref.setKeyValue<int>(Keys.groupId, group.id);
    await _pref.setKeyValue<bool>(Keys.isFirstTime, false).then((value) {
      context.go(RoutesPath.home);
    });
  }
}
