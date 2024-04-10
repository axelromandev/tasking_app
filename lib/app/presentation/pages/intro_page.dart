import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../presentation.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(BoxIcons.bxs_crown, color: colors.primary, size: 28),
                  const Gap(defaultPadding / 2),
                  Text('Tasking',
                      style: style.displaySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colors.primary,
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  S.of(context).intro_subtitle,
                  style: style.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_time),
                textColor: Colors.white,
                title: Text(S.of(context).intro_option1),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_bell),
                textColor: Colors.white,
                title: Text(S.of(context).intro_option2),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_mobile_alt),
                textColor: Colors.white,
                title: Text(S.of(context).intro_option3),
              ),
              const Gap(4),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_shield),
                textColor: Colors.white,
                title: Text(S.of(context).intro_option4),
              ),
              const Spacer(),
              Text(S.of(context).intro_disclaimer),
              CustomFilledButton(
                margin: const EdgeInsets.only(top: defaultPadding),
                onPressed: () => context.push(RoutesPath.introSetup),
                textStyle: style.titleLarge,
                child: Text(S.of(context).intro_button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  final IconData icon;

  const _Leading({required this.icon});

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
