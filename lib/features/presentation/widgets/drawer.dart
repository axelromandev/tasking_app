import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../providers/select_list_id_provider.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final listId = ref.watch(selectListIdProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              visualDensity: VisualDensity.compact,
              leading:
                  Icon(BoxIcons.bxs_crown, color: colors.primary, size: 22),
              title: Text('Tasking', style: style.titleMedium),
            ),
            const Divider(),
            _ListTitleShowAll(current: listId),
            const Divider(),
            ListTile(
              visualDensity: VisualDensity.compact,
              leading: const Icon(BoxIcons.bx_list_ul,
                  size: 16, color: Colors.white70),
              title: Text('LIST',
                  style: style.bodySmall?.copyWith(
                    color: Colors.white70,
                  )),
            ),
            // ListTile(
            //   onTap: () {
            //     ref.read(selectListIdProvider.notifier).change(1);
            //     context.pop();
            //   },
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(0),
            //   ),
            //   tileColor: listId == 1 ? Colors.white.withOpacity(.06) : null,
            //   visualDensity: VisualDensity.compact,
            //   leading: const Icon(
            //     BoxIcons.bxs_circle,
            //     size: 16,
            //     color: Colors.redAccent,
            //   ),
            //   title: const Text('Tutorial'),
            //   trailing: Text('4',
            //       style: style.bodySmall?.copyWith(
            //         color: Colors.white70,
            //       )),
            // ),
            const Spacer(),
            const Divider(),
            ListTile(
              onTap: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              visualDensity: VisualDensity.compact,
              leading: const Icon(BoxIcons.bxs_cog, size: 16),
              title: Text('Settings', style: style.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTitleShowAll extends ConsumerWidget {
  const _ListTitleShowAll({
    required this.current,
  });

  final int current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return ListTile(
      onTap: () {
        ref.read(selectListIdProvider.notifier).change(0);
        context.pop();
      },
      tileColor: current == 0 ? Colors.white.withOpacity(.06) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      visualDensity: VisualDensity.compact,
      leading: const Icon(BoxIcons.bxs_inbox, size: 18),
      title: Text('ALL', style: style.bodyMedium),
    );
  }
}
