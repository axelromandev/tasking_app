import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/domain/domain.dart';
import 'package:tasking/generated/l10n.dart';

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
                    child: Text(S.of(context).group_options_delete,
                        style: style.titleLarge),
                  ),
                  subtitle: Text(
                    S.of(context).group_delete_description,
                    style: style.bodyLarge,
                  ),
                ),
                const Gap(defaultPadding),
                CustomFilledButton(
                  onPressed: () {
                    //TODO: Eliminar grupo
                  },
                  backgroundColor: Colors.red,
                  child: Text(S.of(context).group_options_delete),
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
              title: Text(S.of(context).group_options_rename),
            ),
            ListTile(
              onTap: () async {
                //TODO: Cambiar icono del grupo
              },
              leading: Icon(group.icon!.iconData),
              title: Text(S.of(context).group_options_icon),
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
                title: Text(S.of(context).group_options_delete,
                    style: const TextStyle(color: Colors.redAccent)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
