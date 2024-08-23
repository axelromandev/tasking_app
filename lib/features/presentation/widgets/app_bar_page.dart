import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';

class AppBarPage extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarPage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              BoxIcons.bx_chevron_left,
              size: 30.0,
              color: ref.watch(colorThemeProvider),
            ),
          ),
          const Gap(16.0),
          Text(title, style: style.bodyLarge),
        ],
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
