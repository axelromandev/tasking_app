import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

//TODO: ListTasksAddModal icon picker

class ListTasksAddModal extends ConsumerStatefulWidget {
  const ListTasksAddModal({super.key});

  @override
  ConsumerState<ListTasksAddModal> createState() => _ListTasksAddModalState();
}

class _ListTasksAddModalState extends ConsumerState<ListTasksAddModal> {
  final List<_IconItem> icons = [
    const _IconItem(
      active: IconsaxBold.folder,
      inactive: IconsaxOutline.folder,
    ),
    const _IconItem(
      active: IconsaxBold.home_2,
      inactive: IconsaxOutline.home_2,
    ),
    const _IconItem(
      active: IconsaxBold.briefcase,
      inactive: IconsaxOutline.briefcase,
    ),
    const _IconItem(
      active: IconsaxBold.cloud,
      inactive: IconsaxOutline.cloud,
    ),
    const _IconItem(
      active: IconsaxBold.lock,
      inactive: IconsaxOutline.lock,
    ),
    const _IconItem(
      active: IconsaxBold.star_1,
      inactive: IconsaxOutline.star,
    ),
    const _IconItem(
      active: IconsaxBold.heart,
      inactive: IconsaxOutline.heart,
    ),
    const _IconItem(
      active: IconsaxBold.document_download,
      inactive: IconsaxOutline.document_download,
    ),
    const _IconItem(
      active: IconsaxBold.document_upload,
      inactive: IconsaxOutline.document_upload,
    ),
    const _IconItem(
      active: IconsaxBold.edit,
      inactive: IconsaxOutline.edit,
    ),
    const _IconItem(
      active: IconsaxBold.search_normal,
      inactive: IconsaxOutline.search_normal,
    ),
    const _IconItem(
      active: IconsaxBold.setting,
      inactive: IconsaxOutline.setting,
    ),
    const _IconItem(
      active: IconsaxBold.archive,
      inactive: IconsaxOutline.archive,
    ),
    const _IconItem(
      active: IconsaxBold.document,
      inactive: IconsaxOutline.document,
    ),
    const _IconItem(
      active: IconsaxBold.clipboard_text,
      inactive: IconsaxOutline.clipboard_text,
    ),
    const _IconItem(
      active: IconsaxBold.path_square,
      inactive: IconsaxOutline.path_square,
    ),
    const _IconItem(
      active: IconsaxBold.trend_up,
      inactive: IconsaxOutline.trend_up,
    ),
    const _IconItem(
      active: IconsaxBold.trend_down,
      inactive: IconsaxOutline.trend_down,
    ),
    const _IconItem(
      active: IconsaxBold.user,
      inactive: IconsaxOutline.user,
    ),
    const _IconItem(
      active: IconsaxBold.shield_security,
      inactive: IconsaxOutline.shield,
    ),
    const _IconItem(
      active: IconsaxBold.filter,
      inactive: IconsaxOutline.filter,
    ),
    const _IconItem(
      active: IconsaxBold.trash,
      inactive: IconsaxOutline.trash,
    ),
    const _IconItem(
      active: IconsaxBold.notification,
      inactive: IconsaxOutline.notification,
    ),
    const _IconItem(
      active: IconsaxBold.chart_square,
      inactive: IconsaxOutline.chart_square,
    ),
    const _IconItem(
      active: IconsaxBold.refresh,
      inactive: IconsaxOutline.refresh,
    ),
    const _IconItem(
      active: IconsaxBold.flag,
      inactive: IconsaxOutline.flag,
    ),
    const _IconItem(
      active: IconsaxBold.crown,
      inactive: IconsaxOutline.crown,
    ),
  ];

  int currentIcon = 0;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(listTasksAddProvider);
    final notifier = ref.read(listTasksAddProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: provider.color,
                ),
                child: Text(S.common.buttons.cancel),
              ),
              Text(
                S.modals.listTasks.titleAdd,
                style: style.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomFilledButton(
                onPressed: provider.title.isEmpty
                    ? null
                    : () => notifier.onSubmit(context),
                backgroundColor: provider.color,
                child: Text(S.common.buttons.add),
              ),
            ],
          ),
          const Gap(defaultPadding),
          TextFormField(
            focusNode: notifier.focusNode,
            cursorColor: provider.color,
            onChanged: notifier.onNameChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
            maxLines: null,
            decoration: InputDecoration(
              hintText: S.modals.listTasks.placeholder,
              hintStyle: style.bodyLarge?.copyWith(
                color: Colors.white54,
              ),
            ),
          ),
          const Gap(defaultPadding),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(defaultPadding),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8, // Número de columnas
                crossAxisSpacing: 10.0, // Espacio horizontal entre ítems
                mainAxisSpacing: 10.0, // Espacio vertical entre ítems
              ),
              itemBuilder: (_, index) {
                final icon = icons[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIcon = index;
                    });
                  },
                  child: Icon(
                    (currentIcon == index) ? icon.active : icon.inactive,
                    color: (currentIcon == index) ? Colors.amber : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IconItem {
  const _IconItem({
    required this.active,
    required this.inactive,
  });

  final IconData active;
  final IconData inactive;
}
