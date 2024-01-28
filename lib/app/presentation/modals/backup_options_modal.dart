// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../providers/backup_provider.dart';

class BackupOptionsModal extends ConsumerWidget {
  const BackupOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(backupProvider.notifier);

    final isLoading = ref.watch(backupProvider);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              enabled: !isLoading,
              leading: GestureDetector(
                onTap: () => context.pop(),
                child: isLoading
                    ? SpinPerfect(
                        infinite: true,
                        child: const Icon(BoxIcons.bx_sync),
                      )
                    : const Icon(BoxIcons.bx_x, size: 28),
              ),
              title: Text(
                'Opciones de respaldo',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListTile(
              enabled: !isLoading,
              onTap: notifier.exportToDevice,
              leading: const Icon(BoxIcons.bx_export),
              title: const Text('Exportar en el dispositivo'),
            ),
            ListTile(
              enabled: !isLoading,
              onTap: notifier.importFromDevice,
              leading: const Icon(BoxIcons.bx_import),
              title: const Text('Importar desde el dispositivo'),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
