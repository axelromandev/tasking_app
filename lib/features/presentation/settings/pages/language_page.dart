import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasking/features/presentation/settings/settings.dart';
import 'package:tasking/i18n/i18n.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final Locale? locale = ref.watch(languageProvider);

    final String language = locale?.languageCode ??
        TranslationProvider.of(context).flutterLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.features.settings.languages.title,
          style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                  S.features.settings.languages.title,
                  style: style.titleLarge,
                ),
                content: Text(S.features.settings.languages.gptInfoDialog),
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
          child: ListTile(
            onTap: () {
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
            },
            title: Text(S.common.languages[i]),
            trailing: language == S.common.locales[i]
                ? const Icon(IconsaxOutline.tick_circle)
                : null,
          ),
        ),
      ),
    );
  }
}
