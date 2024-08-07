import 'package:flutter/material.dart';

import '../../../i18n/generated/translations.g.dart';

class TaskDeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(S.common.dialogs.delete.title, style: style.titleLarge),
      content: Text(S.common.dialogs.delete.subtitle, style: style.bodyLarge),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          style: FilledButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: Text(S.common.buttons.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          child: Text(S.common.buttons.delete),
        ),
      ],
    );
  }
}
