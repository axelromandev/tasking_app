import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/const/constants.dart';
import 'package:tasking/generated/l10n.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    String language = S.of(context).language == 'en'
        ? S.of(context).language_en
        : S.of(context).language_es;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).language_label,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).pageLanguageDescription1),
            const Gap(defaultPadding / 2),
            Text.rich(
              TextSpan(text: S.of(context).pageLanguageDescription2, children: [
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
            Text(S.of(context).pageLanguageDescription3),
            const Gap(defaultPadding),
            Text(S.of(context).pageLanguageStep1),
            Text(S.of(context).pageLanguageStep2),
            Text(S.of(context).pageLanguageStep3),
            Text(S.of(context).pageLanguageStep4),
            Text(S.of(context).pageLanguageStep5),
            const Gap(defaultPadding),
            Text(S.of(context).pageLanguageDescription4),
          ],
        ),
      ),
    );
  }
}
