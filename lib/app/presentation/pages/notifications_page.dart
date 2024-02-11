import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../modals/coming_soon_modal.dart';
import '../providers/notifications_provider.dart';
import '../widgets/widgets.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final provider = ref.watch(notificationsProvider);
    final notifier = ref.read(notificationsProvider.notifier);

    String formatTime() {
      final time = provider.reminder;
      String hour = time.hourOfPeriod.toString();
      String minute = time.minute.toString();
      String period = time.period.name.toUpperCase();
      return '${hour.padLeft(2, '0')}:${minute.padLeft(2, '0')} $period';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_general_notifications),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(defaultPadding / 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                S.of(context).pageNotificationsLabel,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTile(
                    iconColor: colors.primary,
                    leading: const Icon(BoxIcons.bx_sun),
                    title: Text(S.of(context).pageNotificationsTitle),
                    trailing: Switch(
                      value: provider.isEnableReminder,
                      // onChanged: notifier.onToggleReminder,

                      //TODO: Uncomment the line below
                      onChanged: (_) => showModalBottomSheet(
                        context: context,
                        elevation: 0,
                        builder: (_) => const ComingSoonModal(),
                      ),
                    ),
                  ),
                  if (provider.isEnableReminder)
                    ListTile(
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_time),
                      title: const Text('Time'),
                      trailing: TextButton(
                        onPressed: () => notifier.onSelectTime(context),
                        child: Text(
                          formatTime(),
                          style: style.titleMedium?.copyWith(
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                S.of(context).pageNotificationsDescription,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            const Gap(defaultPadding),
            if (!provider.isGrantedNotification)
              const DisableNotificationButton(),
          ],
        ),
      ),
    );
  }
}
