import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';

import '../providers/select_group_provider.dart';
import 'add_group_modal.dart';

class SelectGroupModal extends ConsumerWidget {
  const SelectGroupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final provider = ref.watch(selectGroupProvider);
    final notifier = ref.read(selectGroupProvider.notifier);
    final groups = provider.groups;

    void onOptions(GroupTasks group) {
      showModalBottomSheet(
        context: context,
        elevation: 0,
        builder: (_) => Container(
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
                  onTap: () {
                    //TODO: Cambiar icono del grupo
                  },
                  leading: Icon(group.icon!.iconData),
                  title: const Text('Cambiar icono'),
                ),
                const Divider(),
                ListTile(
                  onTap: () => showModalBottomSheet(
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
                                child: Text('Eliminar grupo',
                                    style: style.titleLarge),
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
                  ),
                  leading: const Icon(BoxIcons.bx_trash_alt,
                      color: Colors.redAccent),
                  title: const Text('Eliminar grupo',
                      style: TextStyle(color: Colors.redAccent)),
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
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(BoxIcons.bx_x, size: 28),
              ),
              title: const Text('Seleccionar grupo'),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: groups.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return Card(
                    color: isDarkMode ? null : Colors.white70,
                    child: ListTile(
                      onTap: () {
                        ref.read(homeProvider.notifier).onSelectGroup(group);
                        context.pop();
                      },
                      onLongPress: () => onOptions(group),
                      leading: Icon(group.icon!.iconData),
                      title: Text(group.name, style: style.titleLarge),
                      subtitle: const Text('Mantén para más opciones'),
                      trailing: Text(group.tasks.length.toString(),
                          style: style.bodyLarge),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: isDarkMode ? null : Colors.white70,
              child: ListTile(
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    elevation: 0,
                    builder: (_) => const AddGroupModal(),
                  );
                  notifier.initialize();
                },
                leading: const Icon(BoxIcons.bx_list_plus),
                title: const Text('Agregar grupo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
