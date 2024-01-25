import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/generated/l10n.dart';

class PermissionNotificationModal extends StatelessWidget {
  const PermissionNotificationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: defaultPadding),
            const Icon(BoxIcons.bx_bell, size: 40),
            const SizedBox(height: defaultPadding),
            Container(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: Text(S.of(context).intro_notification_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: Text(
                S.of(context).intro_notification_body,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Gap(defaultPadding),
            CustomFilledButton(
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
              onPressed: () => context.pop(),
              child: Text(S.of(context).button_continue),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
