import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ArchivedConfirmDialog extends StatelessWidget {
  const ArchivedConfirmDialog({
    required this.titleList,
    required this.colorList,
    super.key,
  });

  final String titleList;
  final Color colorList;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(defaultPadding * 2),
      title: Text(
        S.dialogs.listTasksArchived.title,
        style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      content: Text.rich(
        S.dialogs.listTasksArchived.content(
          listTitle: TextSpan(
            text: titleList,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        style: style.bodyLarge?.copyWith(
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomFilledButton(
                height: 45,
                onPressed: () => Navigator.pop(context, false),
                backgroundColor: AppColors.card,
                foregroundColor: Colors.white,
                child: Text(S.common.buttons.cancel),
              ),
            ),
            const Gap(defaultPadding),
            Expanded(
              child: CustomFilledButton(
                height: 45,
                onPressed: () => Navigator.pop(context, true),
                backgroundColor: colorList,
                child: Text(S.dialogs.listTasksArchived.title),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
