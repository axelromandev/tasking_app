// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_label_about),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              margin: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: MyColors.cardDark,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Column(
                children: [
                  const Gap(defaultPadding),
                  SvgPicture.asset('assets/svg/logo.svg',
                      width: 40, color: colors.primary),
                  const Gap(defaultPadding),
                  Text('Tasking',
                      style: style.displaySmall?.copyWith(
                        color: Colors.white,
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: defaultPadding),
                    child: Text(
                      S.of(context).about_description,
                      textAlign: TextAlign.center,
                      style: style.bodyLarge,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final uri = Uri.parse(Urls.githubRepo);
                      if (!await launchUrl(uri)) {
                        Snackbar.show('Could not launch $uri',
                            type: SnackBarType.error);
                      }
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(BoxIcons.bxl_github),
                          const Gap(defaultPadding / 2),
                          Text('Github', style: style.bodyLarge),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              margin: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: MyColors.cardDark,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Column(
                children: [
                  const Gap(defaultPadding),
                  const AdvancedAvatar(
                    size: 80,
                    image: NetworkImage(
                      'https://avatars.githubusercontent.com/u/60910680?v=4',
                    ),
                  ),
                  const Gap(defaultPadding),
                  Text(S.of(context).about_author,
                      style: style.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                  const Gap(defaultPadding),
                  Text(
                    S.of(context).about_author_description,
                    textAlign: TextAlign.center,
                    style: style.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () async {
                      final uri = Uri.parse(Urls.linkedin);
                      if (!await launchUrl(uri)) {
                        Snackbar.show('Could not launch $uri',
                            type: SnackBarType.error);
                      }
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(BoxIcons.bxl_linkedin_square),
                          const Gap(defaultPadding / 2),
                          Text('Linkedin', style: style.bodyLarge),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(defaultPadding / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).about_built_part1),
                const Icon(BoxIcons.bxl_flutter, color: Colors.cyan),
                Text(S.of(context).about_built_part2),
                const Icon(BoxIcons.bxs_heart, color: Colors.red),
              ],
            ),
            const Gap(defaultPadding * 2),
          ],
        ),
      ),
    );
  }
}
