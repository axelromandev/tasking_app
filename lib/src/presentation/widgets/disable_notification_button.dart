import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/l10n.dart';

class DisableNotificationButton extends StatelessWidget {
  const DisableNotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openAppSettings(),
      child: Row(
        children: [
          const Icon(BoxIcons.bx_bell, size: 16, color: Colors.red),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              S.of(context).page_notifications_error_permission,
              style: const TextStyle(
                color: Colors.red,
                decorationColor: Colors.red,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
