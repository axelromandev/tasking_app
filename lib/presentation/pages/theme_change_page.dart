import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';

class ThemesChangePage extends ConsumerWidget {
  const ThemesChangePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: ThemeChangePage Implement slang

    final style = Theme.of(context).textTheme;

    final selected = ref.watch(colorThemeProvider);
    final notifier = ref.read(colorThemeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.pages.settings.appearance.theme,
          style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const ListTile(
              title: Text(
                'Puedes cambiar el color de tema aquí, esto afectara unicamente '
                'a cosas como, iconos, botones y otros textos resaltados.',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
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
          return GestureDetector(
            onTap: () {
              notifier.setColor(color.value);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultPadding),
                side: BorderSide(
                  color: (selected.value == color.value.value)
                      ? color.value
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ListTile(
                leading: const Icon(BoxIcons.bx_palette),
                iconColor: color.value,
                title: Text(color.name),
                trailing: (selected.value == color.value.value)
                    ? const Text('Selected')
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
