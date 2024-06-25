import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';

class ReminderOptionsModal extends ConsumerWidget {
  const ReminderOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: ReminderOptionsModal Implement build method.

    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {},
            shape: const RoundedRectangleBorder(),
            iconColor: colorPrimary,
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Tomorrow morning'),
            trailing: Text('8:00 AM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () {},
            shape: const RoundedRectangleBorder(),
            iconColor: colorPrimary,
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Tomorrow evening'),
            trailing: Text('6:00 PM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () {},
            shape: const RoundedRectangleBorder(),
            iconColor: colorPrimary,
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Monday morning'),
            trailing: Text('Mon 8:00 AM', style: style.bodyLarge),
          ),
          ListTile(
            onTap: () {},
            shape: const RoundedRectangleBorder(),
            iconColor: colorPrimary,
            leading: const Icon(BoxIcons.bx_time),
            title: const Text('Pick a date & time'),
          ),
        ],
      ),
    );
  }
}
