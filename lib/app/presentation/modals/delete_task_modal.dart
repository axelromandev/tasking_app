import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../widgets/widgets.dart';

class DeleteTaskModal extends StatelessWidget {
  const DeleteTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final isDarkMode = Brightness.dark == Theme.of(context).brightness;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                S.of(context).dialog_delete_title,
                style: style.titleLarge,
              ),
              subtitle: Text(
                S.of(context).dialog_delete_subtitle,
                style: style.bodyLarge,
              ),
            ),
            const Gap(defaultPadding),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Row(
                children: [
                  Expanded(
                    child: CustomFilledButton(
                      onPressed: () => context.pop(),
                      backgroundColor:
                          isDarkMode ? MyColors.cardDark : Colors.white,
                      foregroundColor: isDarkMode ? Colors.white : Colors.black,
                      child: Text(S.of(context).button_cancel),
                    ),
                  ),
                  const Gap(defaultPadding),
                  Expanded(
                    child: CustomFilledButton(
                      onPressed: () => context.pop(true),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(S.of(context).button_delete_task),
                    ),
                  ),
                ],
              ),
            ),
            if (Platform.isAndroid) const Gap(defaultPadding),
          ],
        ),
      ),
    );
  }
}
