import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';

class ReminderOptionsModal extends StatelessWidget {
  const ReminderOptionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: ReminderOptionsModal Implement build method.

    final style = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {},
          leading: const Icon(BoxIcons.bx_time),
          title: const Text('Tomorrow morning'),
          trailing: Text('8:00 AM', style: style.bodyLarge),
        ),
        ListTile(
          leading: const Icon(BoxIcons.bx_time),
          title: const Text('Tomorrow evening'),
          trailing: Text('6:00 PM', style: style.bodyLarge),
        ),
        ListTile(
          leading: const Icon(BoxIcons.bx_time),
          title: const Text('Monday morning'),
          trailing: Text('Mon 8:00 AM', style: style.bodyLarge),
        ),
        const ListTile(
          leading: Icon(BoxIcons.bx_time),
          title: Text('Pick a date & time'),
        ),
        if (Platform.isAndroid) const Gap(defaultPadding),
      ],
    );
  }
}
