import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ListTasksAddPage extends ConsumerStatefulWidget {
  const ListTasksAddPage({super.key});

  @override
  ConsumerState<ListTasksAddPage> createState() => _ListTasksAddModalState();
}

class _ListTasksAddModalState extends ConsumerState<ListTasksAddPage> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);
    final provider = ref.watch(listTasksAddProvider);
    final notifier = ref.read(listTasksAddProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(IconsaxOutline.arrow_left_2),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(IconsaxOutline.add, color: colorPrimary),
            const Gap(12),
            Text(
              S.features.lists.addModal.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            TextFormField(
              focusNode: notifier.focusNode,
              cursorColor: colorPrimary,
              onChanged: notifier.onNameChanged,
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                hintText: S.features.lists.forms.placeholder,
                hintStyle: style.bodyLarge?.copyWith(
                  color: Colors.white54,
                ),
              ),
            ),
            const Gap(defaultPadding),
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text('Seleccionar icono', style: style.bodyMedium),
                  ),
                  IconPicker(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    icon: provider.icon,
                    onIconChanged: notifier.onIconChanged,
                  ),
                ],
              ),
            ),
            const Gap(defaultPadding),
            CustomFilledButton(
              width: double.infinity,
              height: 55,
              onPressed: () => notifier.onSubmit(context),
              child: Text(S.common.buttons.accept),
            ),
          ],
        ),
      ),
    );
  }
}
