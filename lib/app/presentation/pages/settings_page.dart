import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../modals/backup_options_modal.dart';
import '../modals/theme_change_modal.dart';
import '../presentation.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          S.of(context).settings_title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isDarkMode ? null : Colors.grey[100],
      ),
      backgroundColor: isDarkMode ? null : Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                  child: Text(S.of(context).settings_label_general,
                      style: style.bodyLarge?.copyWith(
                        color: Colors.grey,
                      )),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          elevation: 0,
                          builder: (_) => const BackupOptionsModal(),
                        ),
                        iconColor: colors.primary,
                        leading: const Icon(BoxIcons.bx_cloud),
                        title: Text(S.of(context).settings_general_cloud),
                        trailing: const Icon(BoxIcons.bx_chevron_right),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(defaultRadius),
                            topRight: Radius.circular(defaultRadius),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () => context.push(RoutesPath.notifications),
                        iconColor: colors.primary,
                        leading: const Icon(BoxIcons.bx_bell),
                        title:
                            Text(S.of(context).settings_general_notifications),
                        trailing: const Icon(BoxIcons.bx_chevron_right),
                        shape: const RoundedRectangleBorder(),
                      ),
                      ListTile(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          elevation: 0,
                          builder: (_) => const ThemeChangeModal(),
                        ),
                        iconColor: colors.primary,
                        leading: const Icon(BoxIcons.bx_palette),
                        title: Text(S.of(context).settings_custom_theme),
                        trailing: const Icon(BoxIcons.bx_chevron_right),
                        shape: const RoundedRectangleBorder(),
                      ),
                      ListTile(
                        onTap: () => openAppSettings(),
                        iconColor: colors.primary,
                        leading: const Icon(BoxIcons.bx_world),
                        title: Text(S.of(context).language_label),
                        trailing: const Icon(BoxIcons.bx_chevron_right),
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
                  child: Text(S.of(context).settings_label_info,
                      style: style.bodyLarge?.copyWith(
                        color: Colors.grey,
                      )),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => context.push(RoutesPath.about),
                        iconColor: colors.primary,
                        leading: const Icon(BoxIcons.bx_info_circle),
                        title: Text(S.of(context).settings_about_app),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(defaultRadius),
                            topRight: Radius.circular(defaultRadius),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          bool isEnglish = S.of(context).language == 'en';
                          Uri uri = isEnglish
                              ? Uri.parse(Urls.enPrivacyPolicy)
                              : Uri.parse(Urls.esPrivacyPolicy);
                          if (!await launchUrl(uri)) {
                            Snackbar.show('Could not launch $uri',
                                type: SnackBarType.error);
                          }
                        },
                        iconColor: colors.primary,
                        leading: const Icon(BoxIcons.bx_shield),
                        title:
                            Text(S.of(context).settings_legal_privacy_policy),
                        shape: const RoundedRectangleBorder(),
                      ),
                      ListTile(
                        onTap: () async {
                          bool isEnglish = S.of(context).language == 'en';
                          Uri uri = isEnglish
                              ? Uri.parse(Urls.enFeedback)
                              : Uri.parse(Urls.esFeedback);
                          if (!await launchUrl(uri)) {
                            Snackbar.show('Could not launch $uri',
                                type: SnackBarType.error);
                          }
                        },
                        iconColor: colors.primary,
                        leading: const Icon(BoxIcons.bx_envelope),
                        title: Text(S.of(context).settings_support_contact),
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
                  child: Text(S.of(context).settings_label_restore,
                      style: style.bodyLarge?.copyWith(
                        color: Colors.redAccent,
                      )),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: ListTile(
                    onTap: ref.read(homeProvider.notifier).onRestore,
                    textColor: Colors.red,
                    leading: const Icon(BoxIcons.bx_reset, color: Colors.red),
                    title: Text(S.of(context).settings_button_restore_app),
                  ),
                ),
                _BuildVersionLabel(),
                const Gap(defaultPadding * 2)
              ],
            ),
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
  String version = '?';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: defaultPadding),
      child: Text(
        'Version $version:$buildNumber',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
