import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class AppBarTitle extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return AppBar(
      leading: IconButton(
        onPressed: () => context.pop(),
        iconSize: 30.0,
        icon: const Icon(BoxIcons.bx_chevron_left),
      ),
      title: Text(title, style: style.bodyLarge),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
