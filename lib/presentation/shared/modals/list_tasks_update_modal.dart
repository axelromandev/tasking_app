import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/domain/domain.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/presentation/providers/providers.dart';
import 'package:tasking/presentation/shared/shared.dart';

class ListTasksUpdateModal extends ConsumerWidget {
  const ListTasksUpdateModal(this.list, {super.key});

  final ListTasks list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final notifier = ref.read(listTasksUpdateProvider(list).notifier);
    final provider = ref.watch(listTasksUpdateProvider(list));

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: provider.color,
                ),
                child: Text(S.common.buttons.cancel),
              ),
              Text(
                S.modals.listTasks.titleUpdate,
                style: style.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomFilledButton(
                onPressed: provider.title.isEmpty
                    ? null
                    : () => notifier.onSubmit(context),
                backgroundColor: provider.color,
                child: Text(S.common.buttons.save),
              ),
            ],
          ),
          const Gap(defaultPadding),
          TextFormField(
            initialValue: provider.title,
            cursorColor: provider.color,
            onChanged: notifier.onNameChanged,
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
            maxLines: null,
            decoration: InputDecoration(
              hintText: S.modals.listTasks.placeholder,
              hintStyle: style.bodyLarge?.copyWith(
                color: Colors.white54,
              ),
            ),
          ),
          const Gap(defaultPadding),
          Card(
            margin: EdgeInsets.zero,
            child: ColorPicker(
              title: Text(S.modals.listTasks.colorLabel),
              borderRadius: 20,
              enableShadesSelection: false,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.wheel: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.primary: true,
              },
              color: provider.color,
              onColorChanged: notifier.onColorChanged,
            ),
          ),
        ],
      ),
    );
  }
}
