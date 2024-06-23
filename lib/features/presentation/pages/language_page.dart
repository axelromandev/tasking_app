import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    final String language = Localizations.localeOf(context).languageCode == 'en'
        ? S.language_en
        : S.language_es;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(BoxIcons.bx_chevron_left, size: 35),
        ),
        leadingWidth: 50,
        title: Text(
          S.language,
          style: style.headlineMedium,
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.page_language_description_1),
            const Gap(defaultPadding / 2),
            Text.rich(
              TextSpan(
                text: S.page_language_description_2,
                children: [
                  TextSpan(
                    text: language,
                    style: TextStyle(
                      color: colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(defaultPadding),
            Text(S.page_language_description_3),
            const Gap(defaultPadding),
            Text(S.page_language_step_1),
            Text(S.page_language_step_2),
            Text(S.page_language_step_3),
            Text(S.page_language_step_4),
            Text(S.page_language_step_5),
            const Gap(defaultPadding),
            Text(S.page_language_description_4),
          ],
        ),
      ),
    );
  }
}
