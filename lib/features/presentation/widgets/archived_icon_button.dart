import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/modals/modals.dart';
import 'package:tasking/features/presentation/providers/providers.dart';

class ArchivedIconButton extends ConsumerWidget {
  const ArchivedIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(allListTasksProvider).listsArchived;

    if (lists.isEmpty) {
      return const IconButton(
        onPressed: null,
        icon: Icon(BoxIcons.bx_archive, size: 20),
      );
    }

    return IconButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (_) => const ArchivedListTasksModal(),
      ),
      icon: Badge(
        backgroundColor: ref.watch(colorThemeProvider),
        offset: const Offset(8, -7),
        label: Text('${lists.length}'),
        child: const Icon(BoxIcons.bx_archive, size: 20),
      ),
    );
  }
}
