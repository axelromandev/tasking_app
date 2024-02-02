import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/config/const/constants.dart';

class ComingSoonModal extends StatelessWidget {
  const ComingSoonModal({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Row(
                children: [
                  const Icon(BoxIcons.bx_error),
                  const Gap(defaultPadding / 2),
                  Text('Muy pronto', style: style.titleLarge),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Esta función no está disponible todavía. Por favor, vuelva más tarde.',
                  style: style.titleSmall,
                ),
              ),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
