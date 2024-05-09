import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/const/constants.dart';
import '../../../generated/l10n.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    String language = Localizations.localeOf(context).languageCode == 'en'
        ? S.of(context).language_en
        : S.of(context).language_es;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(BoxIcons.bx_chevron_left, size: 35),
        ),
        leadingWidth: 50,
        title: Text(
          S.of(context).language,
          style: style.headlineMedium,
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).page_language_description_1),
            const Gap(defaultPadding / 2),
            Text.rich(
              TextSpan(
                  text: S.of(context).page_language_description_2,
                  children: [
                    TextSpan(
                      text: language,
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
            const Gap(defaultPadding),
            Text(S.of(context).page_language_description_3),
            const Gap(defaultPadding),
            Text(S.of(context).page_language_step_1),
            Text(S.of(context).page_language_step_2),
            Text(S.of(context).page_language_step_3),
            Text(S.of(context).page_language_step_4),
            Text(S.of(context).page_language_step_5),
            const Gap(defaultPadding),
            Text(S.of(context).page_language_description_4),
          ],
        ),
      ),
    );
  }
}
