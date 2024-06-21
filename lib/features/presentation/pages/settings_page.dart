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

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(defaultPadding),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Icon(BoxIcons.bx_chevron_left, size: 35),
                    ),
                  ),
                  Text(
                    S.of(context).settings_title,
                    style: style.headlineMedium,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: defaultPadding * 2,
                  bottom: defaultPadding / 2,
                  left: 24.0,
                ),
                child: Text(
                  S.of(context).settings_label_general,
                  style: style.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      visualDensity: VisualDensity.compact,
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_cloud),
                      title: const Text('Backup / Restore'),
                      trailing: const Icon(
                        BoxIcons.bx_chevron_right,
                        color: Colors.grey,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultRadius),
                          topRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      visualDensity: VisualDensity.compact,
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_bell),
                      title: Text(S.of(context).settings_general_notifications),
                      trailing: const Icon(
                        BoxIcons.bx_chevron_right,
                        color: Colors.grey,
                      ),
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
                margin: const EdgeInsets.only(
                  top: defaultPadding * 2,
                  bottom: defaultPadding / 2,
                  left: 24.0,
                ),
                child: Text(
                  'Appearance',
                  style: style.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    _ExpansionThemeSelected(),
                    ListTile(
                      onTap: () => context.push(Routes.language.path),
                      visualDensity: VisualDensity.compact,
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_world),
                      title: Text(S.of(context).language),
                      trailing: const Icon(
                        BoxIcons.bx_chevron_right,
                        color: Colors.grey,
                      ),
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
                margin: const EdgeInsets.only(
                  top: defaultPadding * 2,
                  bottom: defaultPadding / 2,
                  left: 24.0,
                ),
                child: Text(
                  S.of(context).settings_label_info,
                  style: style.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      visualDensity: VisualDensity.compact,
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_share_alt),
                      title: const Text('Compartir con amigos'),
                      trailing: const Icon(
                        BoxIcons.bx_chevron_right,
                        color: Colors.grey,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultRadius),
                          topRight: Radius.circular(defaultRadius),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      visualDensity: VisualDensity.compact,
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_star),
                      title: const Text('Calificar la app'),
                      trailing: const Icon(
                        BoxIcons.bx_chevron_right,
                        color: Colors.grey,
                      ),
                      shape: const RoundedRectangleBorder(),
                    ),
                    ListTile(
                      onTap: () async {
                        final Uri uri = isEnglish
                            ? Uri.parse(Urls.enFeedback)
                            : Uri.parse(Urls.esFeedback);
                        if (!await launchUrl(uri)) {
                          Snackbar.show(
                            'Could not launch $uri',
                            type: SnackBarType.error,
                          );
                        }
                      },
                      visualDensity: VisualDensity.compact,
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_envelope),
                      title: const Text('Send Feedback'),
                      trailing: const Icon(
                        BoxIcons.bx_chevron_right,
                        color: Colors.grey,
                      ),
                      shape: const RoundedRectangleBorder(),
                    ),
                    ListTile(
                      onTap: () {},
                      visualDensity: VisualDensity.compact,
                      iconColor: colors.primary,
                      leading: const Icon(BoxIcons.bx_heart),
                      title: const Text('Support Developer'),
                      trailing: const Icon(
                        BoxIcons.bx_chevron_right,
                        color: Colors.grey,
                      ),
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
              const Gap(defaultPadding),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding),
                alignment: Alignment.center,
                child: _BuildVersionLabel(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Terms of Service', style: style.bodySmall),
                    const Text('   •   ', style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: () async {
                        final Uri uri = isEnglish
                            ? Uri.parse(Urls.enPrivacyPolicy)
                            : Uri.parse(Urls.esPrivacyPolicy);
                        if (!await launchUrl(uri)) {
                          Snackbar.show(
                            'Could not launch $uri',
                            type: SnackBarType.error,
                          );
                        }
                      },
                      child: Text('Privacy Policy', style: style.bodySmall),
                    ),
                  ],
                ),
              ),
              _MadeByLabel(),
              const Gap(defaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpansionThemeSelected extends ConsumerStatefulWidget {
  @override
  ConsumerState<_ExpansionThemeSelected> createState() =>
      _ExpansionThemeSelectedState();
}

class _ExpansionThemeSelectedState
    extends ConsumerState<_ExpansionThemeSelected> {
  final controller = ExpansionTileController();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ExpansionTile(
      controller: controller,
      onExpansionChanged: (value) {
        setState(() => isExpanded = value);
      },
      collapsedShape: const RoundedRectangleBorder(),
      shape: const RoundedRectangleBorder(),
      visualDensity: VisualDensity.compact,
      leading: Icon(BoxIcons.bx_palette, color: colors.primary),
      title: const Text('Themes', style: TextStyle(color: Colors.white)),
      trailing: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isExpanded ? BoxIcons.bx_chevron_down : BoxIcons.bx_chevron_right,
          color: Colors.grey,
        ),
      ),
      children: [
        ColorPicker(
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.primary: true,
            ColorPickerType.accent: false,
          },
          enableShadesSelection: false,
          color: ref.watch(colorThemeProvider),
          onColorChanged: (color) async {
            ref.read(colorThemeProvider.notifier).setColor(color);
            await Future.delayed(const Duration(milliseconds: 100));
            controller.collapse();
          },
        ),
      ],
    );
  }
}

class _MadeByLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Made with ',
            style: style.bodySmall?.copyWith(color: Colors.grey),
          ),
          const Icon(BoxIcons.bxs_heart, color: Colors.redAccent, size: 16),
          Text(' by ', style: style.bodySmall?.copyWith(color: Colors.grey)),
          Text('@ingedevs', style: style.bodySmall),
        ],
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

  Future<void> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Text(
      'Version $version ($buildNumber)',
      style: style.bodySmall?.copyWith(color: Colors.grey),
    );
  }
}
