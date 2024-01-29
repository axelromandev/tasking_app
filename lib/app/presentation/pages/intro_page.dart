import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/presentation/providers/intro_provider.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../presentation.dart';

class IntroPage extends ConsumerWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorSeed = ref.watch(colorThemeProvider);

    final isDarkMode = Brightness.dark == Theme.of(context).brightness;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Tasking',
                      style: style.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorSeed,
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  S.of(context).intro_subtitle,
                  style: style.titleLarge,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_time),
                title: Text(S.of(context).intro_option1),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_bell),
                title: Text(S.of(context).intro_option2),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_mobile_alt),
                title: Text(S.of(context).intro_option3),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_shield),
                title: Text(S.of(context).intro_option4),
              ),
              const Spacer(),
              Text(S.of(context).intro_disclaimer),
              CustomFilledButton(
                margin: const EdgeInsets.only(top: defaultPadding),
                onPressed: () =>
                    ref.read(introProvider.notifier).onFinish(context),
                textStyle: style.titleLarge,
                foregroundColor: isDarkMode ? Colors.black : Colors.white,
                child: Text(S.of(context).intro_button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Leading extends ConsumerWidget {
  final IconData icon;

  const _Leading({required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSeed = ref.watch(colorThemeProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorSeed.withOpacity(.1),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Icon(icon, color: colorSeed),
    );
  }
}
