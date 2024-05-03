import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/config.dart';
import '../../app.dart';
import '../providers/list_tasks_update_modal_provider.dart';

class ListTasksUpdateModal extends ConsumerWidget {
  const ListTasksUpdateModal(this.list, {super.key});

  final ListTasks list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(listTasksUpdateModalProvider(list));
    final notifier = ref.watch(listTasksUpdateModalProvider(list).notifier);

    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: defaultPadding),
            child: Text('Update List', style: style.bodyLarge),
          ),
          TextFormField(
            style: style.bodyLarge,
            maxLines: null,
            initialValue: provider.name,
            inputFormatters: [
              LengthLimitingTextInputFormatter(60),
            ],
            decoration: InputDecoration(
              hintText: 'List name',
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white12, width: 1),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colors.primary.withOpacity(.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
            ),
            onChanged: notifier.onNameChanged,
          ),
          const Gap(defaultPadding),
          ExpansionTile(
            controller: notifier.expansionTileController,
            leading: ColorIndicator(
              width: 18,
              height: 18,
              borderRadius: 10,
              color: provider.color,
            ),
            iconColor: Colors.white70,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white12,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            collapsedShape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white12,
                width: 1,
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
                onColorChanged: notifier.onColorChanged,
              ),
            ],
          ),
          const Gap(defaultPadding),
          CustomFilledButton(
            onPressed: () => notifier.onSubmit(context),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
