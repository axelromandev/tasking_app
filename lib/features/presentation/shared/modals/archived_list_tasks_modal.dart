import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ArchivedListTasksModal extends ConsumerWidget {
  const ArchivedListTasksModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final lists = ref.watch(listsProvider).listsArchived;
    final notifier = ref.read(listsProvider.notifier);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              S.modals.archivedLists.title,
              style: style.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: lists.length,
            itemBuilder: (_, i) {
              final list = lists[i];
              return ListTile(
                shape: const RoundedRectangleBorder(),
                visualDensity: VisualDensity.compact,
                leading:
                    Icon(IconsaxOutline.record, color: list.color, size: 18),
                title: Text.rich(TextSpan(text: list.title)),
                trailing: CustomFilledButton(
                  onPressed: () {
                    notifier.onUnarchiveList(lists[i].id).then((_) {
                      if (lists.length == 1) context.pop();
                    });
                  },
                  backgroundColor: lists[i].color,
                  child: Text(S.common.buttons.restore),
                ),
              );
            },
          ),
          const Gap(defaultPadding),
        ],
      ),
    );
  }
}
