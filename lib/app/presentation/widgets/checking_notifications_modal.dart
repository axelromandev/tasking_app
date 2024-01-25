import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasking/generated/l10n.dart';

import '../../../config/config.dart';
import 'custom_filled_button.dart';

class CheckingNotificationsModal extends StatefulWidget {
  const CheckingNotificationsModal({super.key});

  @override
  State<CheckingNotificationsModal> createState() =>
      _CheckingNotificationsModalState();
}

class _CheckingNotificationsModalState
    extends State<CheckingNotificationsModal> {
  bool isGranted = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    final status = await Permission.notification.status;
    setState(() => isGranted = status.isGranted);
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  isGranted
                      ? S.of(context).notification_enable_title_modal
                      : S.of(context).notification_disable_title_modal,
                  style: style.headlineSmall,
                ),
              ),
              subtitle: Text(
                isGranted
                    ? S.of(context).notification_enable_description_modal
                    : S.of(context).notification_disable_description_modal,
                style: style.bodyLarge,
              ),
            ),
            const Gap(defaultPadding),
            if (!isGranted)
              CustomFilledButton(
                margin:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
                child: Text(S.of(context).notification_button_modal),
              ),
          ],
        ),
      ),
    );
  }
}
