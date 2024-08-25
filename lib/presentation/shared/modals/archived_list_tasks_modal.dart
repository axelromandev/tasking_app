import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/presentation/providers/providers.dart';

class ArchivedListTasksModal extends ConsumerWidget {
  const ArchivedListTasksModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final lists = ref.watch(homeProvider).listsArchived;
    final notifier = ref.read(homeProvider.notifier);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              S.common.modals.archivedLists.title,
              style: style.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: lists.length,
            itemBuilder: (_, i) {
              final color = Color(lists[i].color ?? 0xFF000000);
              return ListTile(
                contentPadding: const EdgeInsets.only(left: defaultPadding),
                shape: const RoundedRectangleBorder(),
                visualDensity: VisualDensity.compact,
                leading: Icon(BoxIcons.bxs_circle, color: color, size: 18),
                title: Text(lists[i].title),
                trailing: IconButton(
                  onPressed: () {
                    notifier.onUnarchiveList(lists[i].id).then((_) {
                      if (lists.length == 1) {
                        context.pop();
                      }
                    });
                  },
                  icon: const Icon(BoxIcons.bx_archive_out, size: 18),
                ),
              );
            },
          ),
          if (Platform.isAndroid) const Gap(defaultPadding),
        ],
      ),
    );
  }
}
