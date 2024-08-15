import 'dart:ui';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';

class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: AppColors.card,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Color Picker'),
            ),
            ColorPicker(
              padding: const EdgeInsets.only(
                bottom: defaultPadding,
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
              color: color ?? const Color(0xffffc107),
              onColorChanged: (color) => Navigator.pop(context, color),
            ),
          ],
        ),
      ),
    );
  }
}
