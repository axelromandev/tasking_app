import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import '../modals/backup_options_modal.dart';
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
        title: Text(S.of(context).settings_title),
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
                      style: style.bodyLarge),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: ListTile(
                    onTap: () {
                      //TODO: Implementar la funcionalidad de recordatorios.
                    },
                    iconColor: colors.primary,
                    leading: const Icon(BoxIcons.bx_time),
                    title: Text(S.of(context).settings_general_reminders),
                  ),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: ExpansionTile(
                    controller:
                        ref.read(colorThemeProvider.notifier).controller,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    iconColor: colors.primary,
                    collapsedIconColor: colors.primary,
                    leading: const Icon(BoxIcons.bx_palette),
                    title: Text(S.of(context).settings_custom_theme),
                    children: [
                      ColorPicker(
                        color: ref.watch(colorThemeProvider),
                        onColorChanged:
                            ref.read(colorThemeProvider.notifier).setColor,
                        pickersEnabled: const <ColorPickerType, bool>{
                          ColorPickerType.primary: true,
                          ColorPickerType.accent: false,
                        },
                        width: 44,
                        height: 44,
                        enableShadesSelection: false,
                      ),
                    ],
                  ),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: ListTile(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      builder: (_) => const BackupOptionsModal(),
                    ),
                    iconColor: colors.primary,
                    leading: const Icon(BoxIcons.bx_cloud),
                    title: Text(S.of(context).settings_general_cloud),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                  child: Text(
                    'Más información',
                    style: style.bodyLarge,
                  ),
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
                      ),
                    ],
                  ),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: Column(
                    children: [
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
                      ),
                    ],
                  ),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: ListTile(
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
                        topLeft: Radius.circular(defaultRadius),
                        topRight: Radius.circular(defaultRadius),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: isDarkMode ? null : Colors.white,
                  child: ListTile(
                    onTap: () async {
                      final uri = Uri.parse(Urls.kofiProfile);
                      if (!await launchUrl(uri)) {
                        Snackbar.show('Could not launch $uri',
                            type: SnackBarType.error);
                      }
                    },
                    iconColor: colors.primary,
                    leading: const Icon(BoxIcons.bx_coffee),
                    title: Text(S.of(context).settings_support_coffee),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(defaultRadius),
                        bottomRight: Radius.circular(defaultRadius),
                      ),
                    ),
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
                  child: Column(
                    children: [
                      ListTile(
                        onTap: ref.read(homeProvider.notifier).onRestore,
                        textColor: Colors.red,
                        leading:
                            const Icon(BoxIcons.bx_reset, color: Colors.red),
                        title: Text(S.of(context).settings_button_restore_app),
                      ),
                    ],
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
