import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../generated/l10n.dart';
import '../presentation.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(S.of(context).settings_title),
        backgroundColor: isDarkMode ? null : Colors.grey[100],
      ),
      backgroundColor: isDarkMode ? null : Colors.grey[100],
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
                color: isDarkMode ? null : Colors.white,
                child: Column(
                  children: [
                    _BuildLanguageButton(),
                    const Divider(height: 0),
                    _BuildThemeButton(),
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
                color: isDarkMode ? null : Colors.white,
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
                    _BuildVersionLabel(),
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
                color: isDarkMode ? null : Colors.white,
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
                color: isDarkMode ? null : Colors.white,
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
                color: isDarkMode ? null : Colors.white,
                child: Column(
                  children: [
                    // _BuildListTile(
                    //   iconData: BoxIcons.bx_world,
                    //   iconColor: Colors.white,
                    //   title: 'Problema de traducción',
                    // ),
                    // const Divider(height: 0),
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
                onPressed: ref.read(homeProvider.notifier).onRestoreDataApp,
                backgroundColor: Colors.red.withOpacity(.1),
                child: Text(
                  S.of(context).settings_button_restore_app,
                  style: style.bodyLarge?.copyWith(color: Colors.red),
                ),
              ),
              const SizedBox(height: defaultPadding * 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildVersionLabel extends StatefulWidget {
  @override
  State<_BuildVersionLabel> createState() => _BuildVersionLabelState();
}

class _BuildVersionLabelState extends State<_BuildVersionLabel> {
  String version = '-';

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() => version = packageInfo.version);
  }

  @override
  Widget build(BuildContext context) {
    return _BuildListTile(
      iconData: BoxIcons.bx_info_circle,
      iconColor: Colors.orange,
      title: S.of(context).about_version,
      trailing: version,
    );
  }
}

class _BuildLanguageButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    const color = Colors.cyan;

    return ListTile(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cardDarkColor,
          title: Text(S.of(context).settings_general_language),
          content: Text(
            S.of(context).language_description,
            style: style.bodyLarge,
          ),
          actions: [
            CustomOutlinedButton(
              onPressed: () => context.pop(),
              child: Text(S.of(context).button_continue),
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
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: const Icon(Icons.language_outlined, color: color),
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

    const color = Colors.cyan;

    return ListTile(
      shape: const RoundedRectangleBorder(),
      onTap: ref.read(changeThemeProvider.notifier).toggle,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Icon(
          isDarkMode ? BoxIcons.bx_moon : BoxIcons.bx_sun,
          color: color,
        ),
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

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final color = iconColor == Colors.white
        ? isDarkMode
            ? Colors.white
            : Colors.black
        : iconColor;

    return ListTile(
      onTap: onTap,
      shape: shape ?? const RoundedRectangleBorder(),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Icon(iconData, color: color),
      ),
      title: Text(title),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right)
          : Text(trailing!, style: style.bodyLarge),
    );
  }
}
