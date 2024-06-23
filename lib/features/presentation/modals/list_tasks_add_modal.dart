import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/config.dart';
import '../providers/list_tasks_add_modal_provider.dart';
import '../widgets/widgets.dart';

class ListTasksAddModal extends ConsumerWidget {
  const ListTasksAddModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(listTasksAddModalProvider);

    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: defaultPadding),
            child: Text('Add List', style: style.bodyLarge),
          ),
          TextField(
            autofocus: true,
            style: style.bodyLarge,
            maxLines: null,
            inputFormatters: [
              LengthLimitingTextInputFormatter(60),
            ],
            decoration: InputDecoration(
              hintText: 'List name',
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white12),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorPrimary.withOpacity(.5),
                ),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
            ),
            onChanged:
                ref.read(listTasksAddModalProvider.notifier).onNameChanged,
          ),
          const Gap(defaultPadding),
          ExpansionTile(
            controller: ref
                .read(listTasksAddModalProvider.notifier)
                .expansionTileController,
            leading: ColorIndicator(
              width: 18,
              height: 18,
              color: provider.color,
            ),
            iconColor: Colors.white70,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white12,
              ),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            collapsedShape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white12,
              ),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            title: const Text('Color'),
            childrenPadding: EdgeInsets.zero,
            children: [
              ColorPicker(
                color: provider.color,
                enableShadesSelection: false,
                borderRadius: 20,
                width: 36,
                height: 36,
                pickersEnabled: const <ColorPickerType, bool>{
                  ColorPickerType.wheel: false,
                  ColorPickerType.accent: false,
                  ColorPickerType.bw: false,
                  ColorPickerType.custom: false,
                  ColorPickerType.primary: true,
                },
                onColorChanged:
                    ref.read(listTasksAddModalProvider.notifier).onColorChanged,
              ),
            ],
          ),
          const Gap(defaultPadding),
          CustomFilledButton(
            onPressed: () =>
                ref.read(listTasksAddModalProvider.notifier).onSubmit(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
