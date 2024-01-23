// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final color = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_label_about),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            margin: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: isDarkMode ? MyColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Column(
              children: [
                const Gap(defaultPadding),
                SvgPicture.asset('assets/svg/logo.svg',
                    width: 40, color: color),
                const Gap(defaultPadding),
                Text('Tasking', style: style.displaySmall),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: Text(
                    S.of(context).about_description,
                    textAlign: TextAlign.center,
                    style: style.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            margin: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: isDarkMode ? MyColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(defaultRadius),
            ),
            child: Column(
              children: [
                const Gap(defaultPadding),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/dev.png'),
                ),
                const Gap(defaultPadding),
                Text(S.of(context).about_author,
                    style: style.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
                const Gap(defaultPadding),
                Text(
                  S.of(context).about_author_description,
                  textAlign: TextAlign.center,
                  style: style.bodyLarge,
                ),
                const Gap(defaultPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
