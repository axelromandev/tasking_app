import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../providers/providers.dart';

class AddTaskField extends ConsumerStatefulWidget {
  const AddTaskField({super.key});

  @override
  ConsumerState<AddTaskField> createState() => _ButtonAddTaskState();
}

class _ButtonAddTaskState extends ConsumerState<AddTaskField> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final controller = ref.watch(controllerProvider);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: TextFormField(
          onChanged: (_) => setState(() {}),
          controller: controller,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            ref.read(homeProvider.notifier).onSubmit(value);
            setState(() {});
          },
          style: const TextStyle(fontSize: 16),
          maxLines: null,
          autocorrect: false,
          cursorColor: colors.primary,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: colors.primary.withOpacity(.6),
              ),
            ),
            prefixIcon: controller.text.isEmpty
                ? const Icon(HeroIcons.plus)
                : const Icon(BoxIcons.bx_circle),
            hintText: S.of(context).home_button_add,
          ),
        ),
      ),
    );
  }
}
