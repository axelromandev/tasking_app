import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../config/config.dart';
import '../../../generated/strings.g.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static String routePath = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Icon(
                BoxIcons.bx_chevron_left,
                size: 30.0,
                color: ref.watch(colorThemeProvider),
              ),
            ),
            const Gap(16.0),
            Text(S.pages.home.settings, style: style.bodyLarge),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
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
                  _ListTile(
                    onTap: () {
                      // TODO: Implement backup
                    },
                    icon: BoxIcons.bx_cloud,
                    title: S.pages.settings.general.backup,
                    borderRadius: BorderRadius.circular(defaultRadius),
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
                    iconColor: colorPrimary,
                    leading: const Icon(BoxIcons.bx_world),
                    title: Text(S.pages.settings.appearance.language),
                    trailing: Text(
                      S.commons.language,
                      style: style.bodyMedium?.copyWith(color: Colors.grey),
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
                  _ListTile(
                    onTap: () {
                      // TODO: Implement about
                    },
                    icon: BoxIcons.bx_info_circle,
                    title: S.pages.settings.moreInformation.about,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(defaultRadius),
                      topRight: Radius.circular(defaultRadius),
                    ),
                  ),
                  _ListTile(
                    onTap: () {
                      // TODO: Implement privacy policy
                    },
                    icon: BoxIcons.bx_shield,
                    title: S.pages.settings.moreInformation.privacyPolicy,
                  ),
                  _BuildVersionLabel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListTile extends ConsumerWidget {
  const _ListTile({
    required this.onTap,
    required this.icon,
    required this.title,
    this.borderRadius = BorderRadius.zero,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = ref.watch(colorThemeProvider);

    return ListTile(
      onTap: onTap,
      visualDensity: VisualDensity.compact,
      iconColor: colorPrimary,
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(BoxIcons.bx_chevron_right, color: Colors.grey),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
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

class _BuildVersionLabel extends ConsumerStatefulWidget {
  @override
  ConsumerState<_BuildVersionLabel> createState() => _BuildVersionLabelState();
}

class _BuildVersionLabelState extends ConsumerState<_BuildVersionLabel> {
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

    final colorPrimary = ref.watch(colorThemeProvider);

    return ListTile(
      iconColor: colorPrimary,
      leading: const Icon(BoxIcons.bx_badge_check),
      title: Text('Version', style: style.bodyLarge),
      trailing: Text(
        '$version ($buildNumber)',
        style: style.bodyMedium?.copyWith(color: Colors.grey),
      ),
    );
  }
}
