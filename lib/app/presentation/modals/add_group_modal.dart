import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';

import '../providers/add_group_provider.dart';
import '../widgets/custom_action_button.dart';

class AddGroupModal extends ConsumerWidget {
  const AddGroupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final provider = ref.watch(addGroupProvider);

    final notifier = ref.read(addGroupProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          ListTile(
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(BoxIcons.bx_x, size: 28),
            ),
            title: const Text('Agregar grupo'),
          ),
          const Gap(defaultPadding),
          Row(
            children: [
              CustomActionButton(
                onPressed: () => notifier.onIconChanged(context),
                backgroundColor: isDarkMode ? MyColors.cardDark : Colors.white,
                child: Icon(provider.icon),
              ),
              const Gap(defaultPadding / 2),
              Expanded(
                child: TextField(
                  autofocus: true,
                  controller: notifier.textController,
                  decoration: InputDecoration(
                    hintText: 'Nombre del grupo',
                    fillColor: isDarkMode ? MyColors.cardDark : Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: provider.name.isNotEmpty
                        ? GestureDetector(
                            onTap: notifier.onClearName,
                            child: const Icon(BoxIcons.bx_x),
                          )
                        : null,
                  ),
                  onChanged: notifier.onNameChanged,
                ),
              ),
            ],
          ),
          const Gap(24),
          CustomFilledButton(
            onPressed: provider.name.isNotEmpty
                ? () => notifier.onAddGroup(context)
                : null,
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }
}
