import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';

class BackupPage extends ConsumerWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: BackupPage Implement functionality

    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(IconsaxOutline.arrow_left_2),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconsaxOutline.refresh,
              color: colorPrimary,
            ),
            const Gap(defaultPadding),
            Text(
              'Copia de seguridad',
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              'Haga una copia de seguridad de sus datos y manténgase seguro en su cuenta de Google. '
              'Puede restaurarlos en un nuevo teléfono después de descargar Tasking en él',
              style: style.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ),
          ListTile(
            title: Text(
              'Última copia de seguridad: November 1, 03:38',
              style: style.bodyMedium,
            ),
            subtitle: Text(
              'Tamaño: 1.2 GB',
              style: style.bodyMedium,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: defaultPadding),
            child: FilledButton(
              onPressed: () {},
              child: const Text('Respaldo'),
            ),
          ),
          ListTile(
            title: Text(
              'Administrar el almacenamiento de Google',
              style: style.bodyLarge?.copyWith(
                color: colorPrimary,
              ),
            ),
          ),
          const ListTile(
            title: Text('Cuenta de Google'),
            subtitle: Text(
              'axelroman20@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const ListTile(
            title: Text('Frecuencia'),
            subtitle: Text(
              'Semanalmente',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SwitchListTile(
            value: false,
            onChanged: (value) {},
            contentPadding: const EdgeInsets.only(left: 16, right: 8),
            title: const Text('Copia de seguridad automática'),
          ),
        ],
      ),
    );
  }
}
