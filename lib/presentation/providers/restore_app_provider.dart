import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/core/core.dart';
import 'package:tasking/presentation/providers/providers.dart';

final restoreAppProvider =
    StateNotifierProvider.autoDispose<_Notifier, void>((ref) {
  final refresh = ref.read(allListTasksProvider.notifier).refreshAll;

  return _Notifier(refresh);
});

class _Notifier extends StateNotifier<void> {
  _Notifier(this.refresh) : super(null);

  final Future<void> Function() refresh;
  final db = DatabaseHelper();

  Future<void> onRestore(BuildContext context) async {
    try {
      await db.restore().then((_) {
        refresh();
        context.pop();
      });
    } catch (e) {
      MyToast.show(e.toString());
    }
  }
}
