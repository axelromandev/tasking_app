import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ListTasksUpdateModal extends ConsumerWidget {
  const ListTasksUpdateModal(this.list, {super.key});

  final ListTasks list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final notifier = ref.read(listTasksUpdateProvider(list).notifier);
    final provider = ref.watch(listTasksUpdateProvider(list));

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(IconsaxOutline.arrow_left_2, size: 20),
                ),
              ),
              Align(
                child: Text(
                  S.modals.listTasks.titleUpdate,
                  style: style.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const Gap(defaultPadding / 2),
          TextFormField(
            initialValue: provider.title,
            onChanged: notifier.onNameChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
            cursorColor: colorPrimary,
            maxLines: null,
            decoration: InputDecoration(
              hintText: S.modals.listTasks.placeholder,
              hintStyle: style.bodyLarge?.copyWith(
                color: Colors.white54,
              ),
            ),
          ),
          const Gap(defaultPadding),
          Card(
            margin: EdgeInsets.zero,
            child: ExpansionTile(
              visualDensity: VisualDensity.compact,
              title: Row(
                children: [
                  Text('Seleccionar icono', style: style.bodyMedium),
                  const Gap(defaultPadding),
                  Icon(provider.icon, color: colorPrimary),
                ],
              ),
              shape: const RoundedRectangleBorder(),
              textColor: Colors.white,
              collapsedTextColor: Colors.white,
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              children: [
                IconPicker(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                    right: defaultPadding,
                    bottom: defaultPadding,
                  ),
                  icon: provider.icon,
                  onIconChanged: notifier.onIconChanged,
                ),
              ],
            ),
          ),
          const Gap(defaultPadding),
          CustomFilledButton(
            width: double.infinity,
            height: 55,
            onPressed: () => notifier.onSubmit(context),
            child: Text(S.common.buttons.save),
          ),
          const Gap(defaultPadding),
          TextButton.icon(
            onPressed: () async {
              final result = await showDialog<bool?>(
                context: context,
                builder: (_) => ListTaskDeleteDialog(list.id),
              );
              if (result != null && result) {
                //FIXME: ListTasksUpdateModal delete list
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.redAccent,
            ),
            icon: const Icon(IconsaxOutline.trash, size: 20),
            label: const Text('Eliminar lista'),
          ),
        ],
      ),
    );
  }
}
