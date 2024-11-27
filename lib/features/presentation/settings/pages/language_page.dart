import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/settings/settings.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:tasking/widgets/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    final Locale? locale = ref.watch(languageProvider);

    final String language = locale?.languageCode ??
        TranslationProvider.of(context).flutterLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              IconsaxOutline.language_square,
              color: colorPrimary,
            ),
            const Gap(defaultPadding),
            Text(
              S.features.settings.languages.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  S.features.settings.languages.title,
                  style: style.titleLarge,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.features.settings.languages.gptInfoDialog,
                      style: style.bodyLarge,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => launchUrlString(Urls.languageFeedback),
                        child: Text(S.common.buttons.sendFeedback),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            icon: const Icon(IconsaxOutline.info_circle),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: S.common.languages.length,
        itemBuilder: (_, i) => Card(
          color: (language == S.common.locales[i])
              ? colorPrimary.withOpacity(0.04)
              : null,
          child: ListTile(
            onTap: () {
              showDialog<bool?>(
                context: context,
                builder: (_) => _ConfirmChange(),
              ).then((value) {
                if (value != null && value) {
                  ref
                      .read(languageProvider.notifier)
                      .setLocale(S.common.locales[i]);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AlertDialog(
                      content: Text(
                        S.features.settings.languages.changedLanguage,
                        style: style.bodyLarge,
                      ),
                    ),
                  );
                }
              });
            },
            shape: (language == S.common.locales[i])
                ? RoundedRectangleBorder(
                    side: BorderSide(color: colorPrimary),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  )
                : null,
            title: Text(S.common.languages[i]),
            trailing: (language == S.common.locales[i])
                ? Text(
                    S.common.labels.selected,
                    style: style.bodySmall?.copyWith(
                      color: colorPrimary,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class _ConfirmChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(
        S.features.settings.languages.confirmDialog.title,
        style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      content: Text(
        S.features.settings.languages.confirmDialog.subtitle,
        style: style.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomFilledButton(
                height: 50,
                onPressed: () => Navigator.pop(context, false),
                backgroundColor: AppColors.card,
                foregroundColor: Colors.white,
                child: Text(S.common.buttons.cancel),
              ),
            ),
            const Gap(defaultPadding),
            Expanded(
              child: CustomFilledButton(
                height: 50,
                onPressed: () => Navigator.pop(context, true),
                child: Text(S.common.buttons.confirm),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
