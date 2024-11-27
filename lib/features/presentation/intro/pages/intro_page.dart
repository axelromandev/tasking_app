import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/shared/shared.dart';
import 'package:tasking/i18n/i18n.dart';

class IntroPage extends ConsumerWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    IconsaxBold.crown_1,
                    color: colorPrimary,
                    size: 32,
                  ),
                  const Gap(defaultPadding / 2),
                  Text(
                    'Tasking',
                    style: style.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(defaultPadding / 2),
                  Text(
                    'beta',
                    style: style.bodyLarge?.copyWith(color: colorPrimary),
                  ),
                ],
              ),
              const Gap(defaultPadding),
              Text(
                S.features.intro.page.title,
                style: style.titleLarge?.copyWith(color: Colors.white),
              ),
              const Gap(defaultPadding),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: IconsaxBold.timer),
                textColor: Colors.white,
                titleTextStyle: style.bodyLarge,
                title: Text(S.features.intro.page.feature1),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: IconsaxBold.mobile),
                textColor: Colors.white,
                title: Text(S.features.intro.page.feature2),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: IconsaxBold.key),
                textColor: Colors.white,
                title: Text(S.features.intro.page.feature3),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: IconsaxBold.notification),
                textColor: Colors.white,
                title: Text(S.features.intro.page.feature4),
              ),
              const Spacer(),
              Text(S.features.intro.page.disclaimer),
              CustomFilledButton(
                width: double.infinity,
                margin: const EdgeInsets.only(top: defaultPadding),
                onPressed: () => context.go('/tutorial'),
                textStyle: style.titleLarge,
                child: Text(S.features.intro.page.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Leading extends ConsumerWidget {
  const _Leading({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: colorPrimary),
    );
  }
}
