import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../i18n/generated/translations.g.dart';

class ThemeColorSelectModal extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      margin: const EdgeInsets.only(bottom: defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            iconColor: ref.watch(colorThemeProvider),
            leading: const Icon(BoxIcons.bx_palette),
            title: Text(S.pages.settings.appearance.theme),
          ),
          ColorPicker(
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
            },
            padding: EdgeInsets.zero,
            enableShadesSelection: false,
            color: ref.watch(colorThemeProvider),
            onColorChanged: (color) async {
              ref.read(colorThemeProvider.notifier).setColor(color);
              await Future.delayed(const Duration(milliseconds: 100), () {
                context.pop();
              });
            },
          ),
        ],
      ),
    );
  }
}
