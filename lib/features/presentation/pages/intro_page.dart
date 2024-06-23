import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../providers/intro_provider.dart';
import '../widgets/widgets.dart';

class IntroPage extends ConsumerWidget {
  const IntroPage({super.key});

  static String routePage = '/intro';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    final style = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(BoxIcons.bxs_crown, color: colorPrimary, size: 28),
                  const Gap(defaultPadding / 2),
                  Text(
                    S.of(context).app_name,
                    style: style.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  S.of(context).page_intro_subtitle,
                  style: style.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_time),
                textColor: Colors.white,
                title: Text(S.of(context).page_intro_feature_1),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_devices),
                textColor: Colors.white,
                title: Text(S.of(context).page_intro_feature_2),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_shield),
                textColor: Colors.white,
                title: Text(S.of(context).page_intro_feature_3),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_bell),
                textColor: Colors.white,
                title: Text(S.of(context).page_intro_feature_4),
              ),
              const Spacer(),
              Text(S.of(context).page_intro_disclaimer),
              CustomFilledButton(
                margin: const EdgeInsets.only(top: defaultPadding),
                onPressed: () => ref.read(introProvider).call(context),
                textStyle: style.titleLarge,
                child: Text(S.of(context).page_intro_button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}
