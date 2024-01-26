import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';

class BackupOptionsModal extends ConsumerWidget {
  const BackupOptionsModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                //TODO: Implementar la funcionalidad de exportar en el dispositivo
              },
              leading: const Icon(BoxIcons.bx_export),
              title: const Text('Exportar en el dispositivo'),
            ),
            ListTile(
              onTap: () {
                //TODO: Implementar la funcionalidad de importar desde el dispositivo
              },
              leading: const Icon(BoxIcons.bx_import),
              title: const Text('Importar desde el dispositivo'),
            ),
            ListTile(
              onTap: () {
                //TODO: Implementar la funcionalidad de exportar a Excel
              },
              leading: const Icon(BoxIcons.bx_box),
              title: const Text('Exportar a Excel'),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
