import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';

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
              child: const Text(
                'Ey! Necesitamos tu permiso',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: const Text(
                'Necesitamos su permiso para enviarle notificaciones sobre sus '
                'tareas y recordatorios. Puede cambiar esto en la configuración de su dispositivo.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            CustomFilledButton(
              margin: const EdgeInsets.only(top: defaultPadding),
              onPressed: () => context.pop(),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
