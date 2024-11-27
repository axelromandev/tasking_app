import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/domain/domain.dart';
import 'package:tasking/features/presentation/lists/lists.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/widgets/widgets.dart';

class ListTasksUpdatePage extends ConsumerWidget {
  const ListTasksUpdatePage(this.list, {super.key});

  final ListTasks list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final notifier = ref.read(listTasksUpdateProvider(list).notifier);
    final provider = ref.watch(listTasksUpdateProvider(list));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(IconsaxOutline.arrow_left_2),
            ),
            const Gap(12),
            Text(
              S.features.lists.updateModal.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            TextFormField(
              initialValue: provider.title,
              onChanged: notifier.onNameChanged,
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              cursorColor: colorPrimary,
              maxLines: null,
              decoration: InputDecoration(
                hintText: S.features.lists.forms.placeholder,
                hintStyle: style.bodyLarge?.copyWith(
                  color: Colors.white54,
                ),
              ),
            ),
            const Gap(defaultPadding),
            Card(
              margin: EdgeInsets.zero,
              child: ExpansionTile(
                visualDensity: VisualDensity.compact,
                title: Row(
                  children: [
                    Text('Seleccionar icono', style: style.bodyMedium),
                    const Gap(defaultPadding),
                    Icon(provider.icon, color: colorPrimary),
                  ],
                ),
                shape: const RoundedRectangleBorder(),
                textColor: Colors.white,
                collapsedTextColor: Colors.white,
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                children: [
                  IconPicker(
                    padding: const EdgeInsets.only(
                      left: defaultPadding,
                      right: defaultPadding,
                      bottom: defaultPadding,
                    ),
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
              child: Text(S.common.buttons.save),
            ),
          ],
        ),
      ),
    );
  }
}
