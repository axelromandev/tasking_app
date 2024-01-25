import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../domain/domain.dart';
import '../providers/home_provider.dart';
import '../providers/select_group_provider.dart';
import '../widgets/widgets.dart';
import 'edit_group_modal.dart';

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
                    child: Text(S.of(context).group_options_delete_title,
                        style: style.titleLarge),
                  ),
                  subtitle: Text(
                    S.of(context).group_delete_confirm_description,
                    style: style.bodyLarge,
                  ),
                ),
                const Gap(defaultPadding),
                CustomFilledButton(
                  onPressed: () {
                    //TODO: Eliminar grupo
                  },
                  backgroundColor: Colors.red,
                  child: Text(S.of(context).group_options_delete_title),
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
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (_) => EditGroupModal(group),
                ).then((_) {
                  ref.read(selectGroupProvider.notifier).initialize();
                  Navigator.pop(context);
                });
              },
              leading: const Icon(BoxIcons.bx_edit),
              title: Text(S.of(context).group_options_edit),
            ),
            const Divider(),
            if (groupIdSelected != group.id)
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  onDelete();
                },
                leading:
                    const Icon(BoxIcons.bx_trash_alt, color: Colors.redAccent),
                title: Text(S.of(context).group_options_delete_title,
                    style: const TextStyle(color: Colors.redAccent)),
              )
            else
              ListTile(
                leading: const Icon(BoxIcons.bx_trash_alt),
                title: Text(S.of(context).group_options_delete_title),
                subtitle: Text(S.of(context).group_options_delete_subtitle),
              ),
          ],
        ),
      ),
    );
  }
}
