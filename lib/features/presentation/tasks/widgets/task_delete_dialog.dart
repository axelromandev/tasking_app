import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/widgets/widgets.dart';

class TaskDeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(
        S.features.tasks.deleteDialog.title,
        style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      content: Text(
        S.features.tasks.deleteDialog.subtitle,
        style: style.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomFilledButton(
                height: 50,
                onPressed: () => Navigator.pop(context, false),
                backgroundColor: AppColors.card,
                foregroundColor: Colors.white,
                child: Text(S.common.buttons.cancel),
              ),
            ),
            const Gap(defaultPadding),
            Expanded(
              child: CustomFilledButton(
                height: 50,
                onPressed: () => Navigator.pop(context, true),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                child: Text(S.common.buttons.delete),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
