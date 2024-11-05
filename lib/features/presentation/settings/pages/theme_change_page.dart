import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class ThemesChangePage extends ConsumerWidget {
  const ThemesChangePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final selected = ref.watch(colorThemeProvider);
    final notifier = ref.read(colorThemeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(IconsaxOutline.arrow_left_2),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconsaxOutline.color_swatch,
              color: selected,
            ),
            const Gap(defaultPadding),
            Text(
              S.features.settings.themes.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  S.features.settings.themes.title,
                  style: style.titleLarge,
                ),
                content: Text(
                  S.features.settings.themes.description,
                  style: style.bodyLarge,
                ),
              ),
            ),
            icon: const Icon(IconsaxOutline.info_circle),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          top: defaultPadding,
          left: 8,
          right: 8,
          bottom: MediaQuery.of(context).padding.bottom + defaultPadding,
        ),
        itemCount: notifier.colors.length,
        itemBuilder: (_, i) {
          final color = notifier.colors[i];
          return Card(
            color: (selected.value == color.value.value)
                ? color.value.withOpacity(0.04)
                : null,
            child: ListTile(
              onTap: () {
                notifier.setColor(color.value);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                side: BorderSide(
                  color: (selected.value == color.value.value)
                      ? color.value
                      : Colors.transparent,
                ),
              ),
              leading: const Icon(IconsaxOutline.color_swatch),
              iconColor: color.value,
              title: Text(color.name),
              trailing: (selected.value == color.value.value)
                  ? Text(S.common.labels.selected)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
