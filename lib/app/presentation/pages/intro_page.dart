import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../presentation.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _pref = SharedPrefsService();

  void onNext() async {
    await _pref.setKeyValue<bool>(isFirstTimeKey, false).then((value) {
      context.go(RoutesPath.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTitle('Tasking'),
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
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_bell),
                title: Text(S.of(context).intro_option2),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_devices),
                title: Text(S.of(context).intro_option3),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const _Leading(icon: BoxIcons.bx_shield),
                title: Text(S.of(context).intro_option4),
              ),
              const Spacer(),
              Text(S.of(context).intro_disclaimer),
              CustomFilledButton(
                margin: const EdgeInsets.only(top: defaultPadding),
                onPressed: onNext,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final color = isDarkMode ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Icon(icon, color: color),
    );
  }
}
