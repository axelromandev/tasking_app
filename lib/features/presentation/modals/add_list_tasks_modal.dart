import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../widgets/widgets.dart';

class AddListTasksModal extends ConsumerWidget {
  const AddListTasksModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          const Gap(defaultPadding),
          TextField(
            // autofocus: true,
            // controller: notifier.textController,
            style: style.bodyLarge,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'List name',
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white12, width: 1),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.amber.withOpacity(.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              // suffixIcon: provider.name.isNotEmpty
              //     ? GestureDetector(
              //         onTap: notifier.onClearName,
              //         child: const Icon(BoxIcons.bx_x),
              //       )
              //     : null,
            ),
            // onChanged: notifier.onNameChanged,
          ),
          const Gap(defaultPadding),
          ExpansionTile(
            leading: const ColorIndicator(
              width: 18,
              height: 18,
              borderRadius: 10,
              color: Colors.amber,
            ),
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
                color: Colors.amber,
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
                onColorChanged: (value) {},
              ),
            ],
          ),
          const Gap(defaultPadding),
          ExpansionTile(
            leading: const Icon(
              BoxIcons.bxs_star,
              size: 20,
              color: Colors.amber,
            ),
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
            title: const Text('Icono'),
            childrenPadding: EdgeInsets.zero,
            children: const [],
          ),
          const Gap(defaultPadding),
          CustomFilledButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Fluttertoast.showToast(
                msg: 'Please enter a list name.',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            child: const Text('Add'),
          ),
          const Gap(defaultPadding * 3),
        ],
      ),
    );
  }
}
