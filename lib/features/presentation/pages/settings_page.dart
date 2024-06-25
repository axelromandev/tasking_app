import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: defaultPadding / 2,
                bottom: defaultPadding / 2,
                left: 24.0,
              ),
              child: Text(
                S.pages.settings.general.title,
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
                    iconColor: colorPrimary,
                    leading: const Icon(BoxIcons.bx_cloud),
                    title: Text(S.pages.settings.general.backup),
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
                    iconColor: colorPrimary,
                    leading: const Icon(BoxIcons.bx_bell),
                    title: Text(S.pages.settings.general.notifications),
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
                S.pages.settings.appearance.title,
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
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        backgroundColor: AppColors.card,
                        child: Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                S.dialogs.language.title,
                                style: style.bodyLarge,
                              ),
                              const Gap(defaultPadding),
                              Text.rich(
                                TextSpan(
                                  text: S.dialogs.language.subtitle,
                                  style: style.bodyLarge,
                                  children: [
                                    TextSpan(
                                      text: S.commons.language,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                    iconColor: colorPrimary,
                    leading: const Icon(BoxIcons.bx_world),
                    title: Text(S.pages.settings.appearance.language),
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
                S.pages.settings.moreInformation.title,
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
                    iconColor: colorPrimary,
                    leading: const Icon(BoxIcons.bx_info_circle),
                    title: Text(S.pages.settings.moreInformation.about),
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
                    iconColor: colorPrimary,
                    leading: const Icon(BoxIcons.bx_shield),
                    title: Text(S.pages.settings.moreInformation.privacyPolicy),
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
            _MadeByLabel(),
            const Gap(defaultPadding * 2),
          ],
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
    final colorPrimary = ref.watch(colorThemeProvider);

    return ExpansionTile(
      controller: controller,
      onExpansionChanged: (value) {
        setState(() => isExpanded = value);
      },
      collapsedShape: const RoundedRectangleBorder(),
      shape: const RoundedRectangleBorder(),
      visualDensity: VisualDensity.compact,
      leading: Icon(BoxIcons.bx_palette, color: colorPrimary),
      title: Text(
        S.pages.settings.appearance.theme,
        style: const TextStyle(color: Colors.white),
      ),
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
