import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';

class AboutPage extends StatelessWidget {
  static String routePath = '/about';

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final color = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: defaultPadding * 2),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(.1),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Icon(
                  BoxIcons.bxs_crown,
                  color: color,
                  size: 60,
                ),
              ),
              const SizedBox(height: defaultPadding),
              Text('Tasking', style: style.displayMedium),
              Container(
                margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Text(
                  S.of(context).about_description,
                  textAlign: TextAlign.center,
                  style: style.bodyLarge,
                ),
              ),
              const SizedBox(height: defaultPadding * 3),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/dev.jpg'),
              ),
              const SizedBox(height: defaultPadding),
              Text(S.of(context).about_author,
                  style: style.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  )),
              Text(
                S.of(context).about_author_description,
                textAlign: TextAlign.center,
                style: style.bodyLarge,
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
