import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/providers/providers.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class ListTasksAddModal extends ConsumerStatefulWidget {
  const ListTasksAddModal({super.key});

  @override
  ConsumerState<ListTasksAddModal> createState() => _ListTasksAddModalState();
}

class _ListTasksAddModalState extends ConsumerState<ListTasksAddModal> {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);
    final provider = ref.watch(listTasksAddProvider);
    final notifier = ref.read(listTasksAddProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(IconsaxOutline.arrow_left_2, size: 20),
                ),
              ),
              Align(
                child: Text(
                  S.modals.listTasks.titleAdd,
                  style: style.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const Gap(defaultPadding / 2),
          TextFormField(
            focusNode: notifier.focusNode,
            cursorColor: colorPrimary,
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
              prefixIcon: Icon(provider.icon, size: 20),
            ),
          ),
          const Gap(defaultPadding),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(defaultPadding),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: notifier.icons.length,
              padding: const EdgeInsets.all(defaultPadding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (_, index) {
                final icon = notifier.icons[index];
                return GestureDetector(
                  onTap: () => notifier.onIconChanged(icon),
                  child: Icon(
                    icon,
                    color:
                        (provider.icon == icon) ? Colors.white : Colors.white70,
                  ),
                );
              },
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
    );
  }
}
