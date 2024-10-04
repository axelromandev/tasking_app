import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final color = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.pages.settings.moreInformation.about,
          style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const Gap(defaultPadding * 2),
          Center(
            child: Container(
              height: 90,
              width: 90,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(IconsaxBold.crown_1, color: color, size: 50),
            ),
          ),
          const Gap(defaultPadding),
          Text(S.pages.about.title, style: style.headlineSmall),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(S.pages.about.description, textAlign: TextAlign.center),
          ),
          const Text.rich(
            TextSpan(
              text: 'Made by ',
              children: [
                TextSpan(
                  text: '@Ingedevs',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Gap(defaultPadding),
          TextButton(
            onPressed: () => launchUrlString(Urls.repo),
            child: Text(S.pages.about.repo),
          ),
        ],
      ),
    );
  }
}
