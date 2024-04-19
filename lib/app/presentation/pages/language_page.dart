import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/const/constants.dart';
import '../../../generated/l10n.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    String language = Localizations.localeOf(context).languageCode == 'en'
        ? S.of(context).LANGUAGE_EN
        : S.of(context).LANGUAGE_ES;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).LANGUAGE,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).PAGE_LANGUAGE_DESCRIPTION1),
            const Gap(defaultPadding / 2),
            Text.rich(
              TextSpan(
                  text: S.of(context).PAGE_LANGUAGE_DESCRIPTION2,
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
            Text(S.of(context).PAGE_LANGUAGE_DESCRIPTION3),
            const Gap(defaultPadding),
            Text(S.of(context).PAGE_LANGUAGE_STEP1),
            Text(S.of(context).PAGE_LANGUAGE_STEP2),
            Text(S.of(context).PAGE_LANGUAGE_STEP3),
            Text(S.of(context).PAGE_LANGUAGE_STEP4),
            Text(S.of(context).PAGE_LANGUAGE_STEP5),
            const Gap(defaultPadding),
            Text(S.of(context).PAGE_LANGUAGE_DESCRIPTION4),
          ],
        ),
      ),
    );
  }
}
