import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/strings.g.dart';
import '../providers/restore_app_provider.dart';

class RestoreAppDialog extends ConsumerWidget {
  const RestoreAppDialog({
    required this.contextPreviousPage,
    super.key,
  });

  final BuildContext contextPreviousPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(restoreAppProvider.notifier);

    return AlertDialog(
      title: Text(S.dialogs.restoreApp.title),
      content: Text(S.dialogs.restoreApp.subtitle),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
            onPressed: () => context.pop(),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: Text(S.buttons.cancel),
          ),
        ),
        FilledButton(
          onPressed: () {
            context.pop();
            notifier.onRestore(contextPreviousPage);
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          child: Text(S.buttons.restore),
        ),
      ],
    );
  }
}
