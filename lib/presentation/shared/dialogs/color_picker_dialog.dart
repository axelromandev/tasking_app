import 'dart:ui';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/presentation/shared/shared.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({this.color, super.key});

  final Color? color;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color selected;

  @override
  void initState() {
    selected = widget.color ?? const Color(0xffffc107);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: AppColors.card,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(
                left: 20,
                right: 8,
              ),
              title: const Text('Theme'),
              trailing: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(BoxIcons.bx_x),
              ),
            ),
            ColorPicker(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              enableShadesSelection: false,
              borderRadius: 20,
              width: 36,
              height: 36,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.wheel: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.primary: true,
              },
              color: selected,
              onColorChanged: (color) => setState(() {
                selected = color;
              }),
            ),
            CustomFilledButton(
              height: 45,
              width: double.infinity,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: 10,
              ),
              onPressed: () => Navigator.pop(context, selected),
              backgroundColor: selected,
              child: Text(S.common.buttons.select),
            ),
          ],
        ),
      ),
    );
  }
}
