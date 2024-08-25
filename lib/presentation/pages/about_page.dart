import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/presentation/shared/shared.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBarTitle(title: S.pages.settings.moreInformation.about),
      body: Column(
        children: [
          const Gap(defaultPadding * 2),
          Center(
            child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset(
                Assets.logo,
                width: 18,
                theme: const SvgTheme(currentColor: Colors.white),
              ),
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
