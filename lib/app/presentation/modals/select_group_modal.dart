import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/generated/l10n.dart';

import '../providers/select_group_provider.dart';
import 'add_group_modal.dart';
import 'options_group_modal.dart';

class SelectGroupModal extends ConsumerWidget {
  const SelectGroupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final provider = ref.watch(selectGroupProvider);
    final notifier = ref.read(selectGroupProvider.notifier);
    final groups = provider.groups;

    final groupIdSelected = ref.watch(homeProvider).group!.id;

    void onOptions(GroupTasks group) {
      HapticFeedback.heavyImpact();
      showModalBottomSheet(
        context: context,
        elevation: 0,
        builder: (_) => OptionsGroupModal(group),
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
              title: Text(S.of(context).group_select_title),
              subtitle: Text(S.of(context).group_select_subtitle),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: groups.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const Gap(defaultPadding / 2),
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return Card(
                    color: isDarkMode ? null : Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius),
                      side: groupIdSelected == group.id
                          ? BorderSide(color: colors.primary.withOpacity(.6))
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      onTap: () {
                        ref.read(homeProvider.notifier).onSelectGroup(group);
                        context.pop();
                      },
                      iconColor: colors.primary,
                      onLongPress: () => onOptions(group),
                      leading: Icon(group.icon!.iconData),
                      title: Text(group.name, style: style.titleLarge),
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
                title: Text(S.of(context).group_add_button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
