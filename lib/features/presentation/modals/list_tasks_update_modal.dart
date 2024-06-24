import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';
import '../../app.dart';
import '../providers/list_tasks_update_modal_provider.dart';

class ListTasksUpdateModal extends ConsumerWidget {
  const ListTasksUpdateModal(this.list, {super.key});

  final ListTasks list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    final provider = ref.watch(listTasksUpdateModalProvider(list));
    final notifier = ref.watch(listTasksUpdateModalProvider(list).notifier);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const Gap(defaultPadding * 2),
              Container(
                margin: const EdgeInsets.only(bottom: defaultPadding),
                child: Text(
                  S.modals.listTasksUpdate.title,
                  style: style.bodyLarge,
                ),
              ),
              TextFormField(
                style: style.bodyLarge,
                initialValue: provider.name,
                maxLength: 30,
                decoration: InputDecoration(
                  hintText: S.modals.listTasksUpdate.placeholder,
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
                onChanged: notifier.onNameChanged,
              ),
              const Gap(defaultPadding),
              ExpansionTile(
                controller: notifier.expansionTileController,
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
                    onColorChanged: notifier.onColorChanged,
                  ),
                ],
              ),
              const Spacer(),
              CustomFilledButton(
                onPressed: () => notifier.onSubmit(context),
                child: Text(S.buttons.update),
              ),
              const Gap(defaultPadding),
              CustomFilledButton(
                onPressed: () => Navigator.pop(context),
                backgroundColor: MyColors.cardDark,
                foregroundColor: Colors.white,
                child: Text(S.buttons.cancel),
              ),
              const Gap(defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
