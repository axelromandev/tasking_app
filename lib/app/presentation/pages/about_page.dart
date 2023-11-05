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
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset('assets/svg/logo.svg', width: 60, color: color),
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
              const Divider(height: defaultPadding * 3),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/dev.jpg'),
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
            ],
          ),
        ),
      ),
    );
  }
}
