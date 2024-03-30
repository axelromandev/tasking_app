import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../providers/backup_provider.dart';

class BackupOptionsModal extends ConsumerWidget {
  const BackupOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(backupProvider.notifier);

    final isLoading = ref.watch(backupProvider);

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                enabled: !isLoading,
                onTap: notifier.exportToDevice,
                leading: const Icon(BoxIcons.bx_export),
                title: Text(S.of(context).backup_export_modal),
              ),
              ListTile(
                enabled: !isLoading,
                onTap: notifier.importFromDevice,
                leading: const Icon(BoxIcons.bx_import),
                title: Text(S.of(context).backup_import_modal),
              ),
              if (Platform.isAndroid) const Gap(defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
