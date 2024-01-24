import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/domain/domain.dart';

import '../../../config/config.dart';
import '../providers/home_provider.dart';
import '../widgets/widgets.dart';

class OptionsGroupModal extends ConsumerWidget {
  const OptionsGroupModal(this.group, {super.key});

  final GroupTasks group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final groupIdSelected = ref.watch(homeProvider).group!.id;

    void onDelete() {
      showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('Eliminar grupo', style: style.titleLarge),
                  ),
                  subtitle: const Text(
                      '¿Estás seguro de eliminar este grupo?, se eliminarán todas las tareas que contiene y no se podrán recuperar.'),
                ),
                const Gap(defaultPadding),
                CustomFilledButton(
                  onPressed: () {
                    //TODO: Eliminar grupo
                  },
                  backgroundColor: Colors.red,
                  child: const Text('Eliminar definitivamente'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                //TODO: Renombrar grupo
              },
              leading: const Icon(BoxIcons.bx_rename),
              title: const Text('Renombrar'),
            ),
            ListTile(
              onTap: () async {
                //TODO: Cambiar icono del grupo
              },
              leading: Icon(group.icon!.iconData),
              title: const Text('Cambiar icono'),
            ),
            if (groupIdSelected != group.id) ...[
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  onDelete();
                },
                leading:
                    const Icon(BoxIcons.bx_trash_alt, color: Colors.redAccent),
                title: const Text('Eliminar grupo',
                    style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
