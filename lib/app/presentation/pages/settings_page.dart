import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';

class SettingsPage extends ConsumerWidget {
  static String routePath = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(S.of(context).settings_title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  S.of(context).settings_label_general,
                  style: style.headlineSmall,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    _BuildLanguageButton(),
                    const Divider(height: 0),
                    _BuildThemeButton(),
                    const Divider(height: 0),
                    _BuildListTile(
                      onTap: () {
                        //TODO: manage reminders
                      },
                      iconData: Icons.notifications,
                      iconColor: Colors.cyan,
                      title: S.of(context).settings_general_reminders,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultRadius),
                          bottomRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  S.of(context).settings_label_about,
                  style: style.headlineSmall,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    _BuildListTile(
                      onTap: () => context.push(AboutPage.routePath),
                      iconData: BoxIcons.bx_crown,
                      iconColor: Colors.orange,
                      title: S.of(context).settings_about_app,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultRadius),
                          topRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                    const Divider(height: 0),
                    _BuildListTile(
                      iconData: BoxIcons.bx_info_circle,
                      iconColor: Colors.orange,
                      title: S.of(context).about_version,
                      trailing: '1.0.0',
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  S.of(context).settings_label_legal,
                  style: style.headlineSmall,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    _BuildListTile(
                      onTap: () {
                        //TODO: open privacy policy url
                      },
                      iconData: BoxIcons.bx_shield,
                      iconColor: Colors.green,
                      title: S.of(context).settings_legal_privacy_policy,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultRadius),
                          topRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                    const Divider(height: 0),
                    _BuildListTile(
                      onTap: () {
                        //TODO: open terms of use url
                      },
                      iconData: BoxIcons.bx_book_alt,
                      iconColor: Colors.green,
                      title: S.of(context).settings_legal_terms_of_use,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultRadius),
                          bottomRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  S.of(context).settings_label_social,
                  style: style.headlineSmall,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    _BuildListTile(
                      onTap: () {
                        //TODO: open app store url
                      },
                      iconData: BoxIcons.bx_star,
                      iconColor: Colors.purpleAccent,
                      title: S.of(context).settings_social_rate_app,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultRadius),
                          topRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                    const Divider(height: 0),
                    _BuildListTile(
                      onTap: () {
                        //TODO: share app
                      },
                      iconData: BoxIcons.bx_share_alt,
                      iconColor: Colors.purpleAccent,
                      title: S.of(context).settings_social_share_app,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultRadius),
                          bottomRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  S.of(context).settings_label_support,
                  style: style.headlineSmall,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    _BuildListTile(
                      onTap: () {
                        //TODO: write email to support
                      },
                      iconData: BoxIcons.bx_envelope,
                      iconColor: Colors.white,
                      title: S.of(context).settings_support_contact,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultRadius),
                          topRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                    const Divider(height: 0),
                    _BuildListTile(
                      onTap: () async {
                        final uri = Uri.parse(kofiProfileUrl);
                        if (!await launchUrl(uri)) {
                          throw Exception('Could not launch $uri');
                        }
                      },
                      iconData: BoxIcons.bx_coffee,
                      iconColor: Colors.white,
                      title: S.of(context).settings_support_coffee,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultRadius),
                          bottomRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomFilledButton(
                margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                onPressed: () {
                  //TODO: add restore application
                },
                child: Text(S.of(context).settings_button_restore_app,
                    style: style.bodyLarge?.copyWith(
                      color: Colors.redAccent,
                    )),
              ),
              const SizedBox(height: defaultPadding * 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildLanguageButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    return ListTile(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).settings_general_language),
          content: Text(
            'El lenguaje de la aplicación se cambiará de '
            'acuerdo con el idioma del dispositivo.',
            style: style.bodyLarge,
          ),
          actions: [
            CustomFilledButton(
              onPressed: () => context.pop(),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultRadius),
          topRight: Radius.circular(defaultRadius),
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: const Icon(Icons.language, color: Colors.white),
      ),
      trailing: Text(
        S.of(context).language == 'en'
            ? S.of(context).language_en
            : S.of(context).language_es,
        style: style.bodyLarge,
      ),
      title: Text(S.of(context).settings_general_language),
    );
  }
}

class _BuildThemeButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final isDarkMode = ref.watch(changeThemeProvider);

    return ListTile(
      shape: const RoundedRectangleBorder(),
      onTap: ref.read(changeThemeProvider.notifier).toggle,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Icon(isDarkMode ? BoxIcons.bxs_moon : BoxIcons.bxs_sun,
            color: Colors.white),
      ),
      trailing: Text(
        isDarkMode
            ? S.of(context).settings_general_dark_mode
            : S.of(context).settings_general_light_mode,
        style: style.bodyLarge,
      ),
      title: Text(S.of(context).settings_general_theme),
    );
  }
}

class _BuildListTile extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData iconData;
  final Color iconColor;
  final String title;
  final String? trailing;
  final ShapeBorder? shape;

  const _BuildListTile({
    this.onTap,
    this.shape,
    required this.iconData,
    required this.iconColor,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      shape: shape ?? const RoundedRectangleBorder(),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Icon(
          iconData,
          color: iconColor == Colors.white ? Colors.black : Colors.white,
        ),
      ),
      title: Text(title),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right)
          : Text(trailing!, style: style.bodyLarge),
    );
  }
}