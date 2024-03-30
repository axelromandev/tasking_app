import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';

class ThemeChangeModal extends ConsumerWidget {
  const ThemeChangeModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(S.of(context).settings_custom_theme),
            ),
            ColorPicker(
              padding: EdgeInsets.zero,
              color: ref.watch(colorThemeProvider),
              onColorChanged: (color) {
                ref.read(colorThemeProvider.notifier).setColor(color);
                Navigator.pop(context);
              },
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.primary: true,
                ColorPickerType.accent: false,
              },
              width: 44,
              height: 44,
              enableShadesSelection: false,
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
