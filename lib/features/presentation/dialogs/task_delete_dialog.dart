import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/const/constants.dart';
import '../../../i18n/generated/translations.g.dart';
import '../../app.dart';

class TaskDeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(
        S.common.dialogs.deleteTask.title,
        style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      content: Text(
        S.common.dialogs.deleteTask.subtitle,
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
