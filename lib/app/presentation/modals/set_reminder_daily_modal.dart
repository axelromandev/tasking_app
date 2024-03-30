import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/presentation/widgets/custom_filled_button.dart';
import 'package:tasking/config/config.dart';

class SetReminderDailyModal extends ConsumerWidget {
  const SetReminderDailyModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorSeed = ref.watch(colorThemeProvider);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(BoxIcons.bx_bell, size: 34, color: colorSeed),
              const Gap(defaultPadding / 2),
              Text('Agrega un recordatorio diario',
                  style: style.titleLarge?.copyWith(
                    color: colorSeed,
                    fontWeight: FontWeight.bold,
                  )),
              const Gap(defaultPadding / 2),
              Text(
                'Asi podrás recordar revisar tus tareas pendientes y completarlas',
                textAlign: TextAlign.center,
                style: style.bodyLarge,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: CustomFilledButton(
                onPressed: () {},
                foregroundColor: Colors.white,
                child: const Text('Continuar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
