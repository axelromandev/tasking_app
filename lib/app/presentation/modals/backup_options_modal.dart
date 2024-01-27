// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../providers/backup_provider.dart';

class BackupOptionsModal extends ConsumerWidget {
  const BackupOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Brightness.dark == Theme.of(context).brightness;

    final notifier = ref.read(backupProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: notifier.exportToDevice,
              leading: const Icon(BoxIcons.bx_export),
              title: const Text('Exportar en el dispositivo'),
            ),
            ListTile(
              onTap: notifier.importFromDevice,
              leading: const Icon(BoxIcons.bx_import),
              title: const Text('Importar desde el dispositivo'),
            ),
            ListTile(
              onTap: notifier.exportToExcel,
              leading: SvgPicture.asset(
                'assets/svg/excel.svg',
                height: 24,
                width: 24,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              title: const Text('Exportar a Excel'),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
