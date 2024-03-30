import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../../app.dart';
import '../providers/edit_group_provider.dart';

class EditGroupModal extends ConsumerWidget {
  const EditGroupModal(this.group, {super.key});

  final GroupTasks group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final provider = ref.watch(editGroupProvider(group));

    final notifier = ref.read(editGroupProvider(group).notifier);

    final icons = <IconData>[
      BoxIcons.bx_list_ul,
      BoxIcons.bx_cart,
      BoxIcons.bx_briefcase,
      BoxIcons.bx_home_alt,
      BoxIcons.bx_car,
      BoxIcons.bx_building,
      BoxIcons.bx_coffee,
      BoxIcons.bx_joystick,
      BoxIcons.bx_music,
      BoxIcons.bx_ghost,
      BoxIcons.bx_money,
      BoxIcons.bx_bitcoin,
      BoxIcons.bx_dollar,
      BoxIcons.bx_user,
      BoxIcons.bx_group,
      BoxIcons.bx_walk,
      BoxIcons.bx_star,
      BoxIcons.bx_sun,
      BoxIcons.bx_moon,
      BoxIcons.bx_heart,
      BoxIcons.bx_note,
    ];

    return Column(
      children: [
        const Gap(defaultPadding),
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(BoxIcons.bx_x, size: 28),
                ),
                title: const Text('Editar grupo'),
              ),
            ),
            FilledButton(
              onPressed: provider.name.isNotEmpty
                  ? () => notifier.onUpdateGroup(context)
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
              ),
              child: Text(S.of(context).button_save),
            ),
            const Gap(defaultPadding),
          ],
        ),
        const Gap(defaultPadding),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: TextField(
            autofocus: true,
            controller: notifier.textController,
            decoration: InputDecoration(
              hintText: S.of(context).group_name_field,
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
        const Gap(defaultPadding),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            width: double.infinity,
            child: Wrap(
              spacing: 8,
              children: icons.map((icon) {
                return CircleAvatar(
                  backgroundColor: icon.codePoint == provider.icon.codePoint
                      ? colors.primary
                      : Colors.transparent,
                  child: IconButton(
                    onPressed: () => notifier.onIconChanged(icon),
                    icon: Icon(
                      icon,
                      color: icon.codePoint == provider.icon.codePoint
                          ? Colors.black
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
