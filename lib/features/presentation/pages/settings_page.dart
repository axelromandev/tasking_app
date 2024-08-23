import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/features/presentation/dialogs/dialogs.dart';
import 'package:tasking/i18n/generated/translations.g.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          iconSize: 30.0,
          icon: const Icon(BoxIcons.bx_chevron_left),
        ),
        title: Text('Settings', style: style.bodyLarge),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: defaultPadding,
                bottom: defaultPadding / 2,
                left: 24.0,
              ),
              child: Text(
                S.pages.settings.general.title,
                style: style.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w300,
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
                      // TODO: implement backup
                    },
                    icon: BoxIcons.bx_reset,
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
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  _ListTile(
                    onTap: () => showDialog<Color?>(
                      context: context,
                      builder: (_) => ColorPickerDialog(color: colorPrimary),
                    ).then((color) {
                      if (color != null) {
                        ref.read(colorThemeProvider.notifier).setColor(color);
                      }
                    }),
                    icon: BoxIcons.bx_palette,
                    title: S.pages.settings.appearance.theme,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(defaultRadius),
                      topRight: Radius.circular(defaultRadius),
                    ),
                  ),
                  ListTile(
                    iconColor: colorPrimary,
                    leading: const Icon(BoxIcons.bx_world),
                    title: Text(S.pages.settings.appearance.language),
                    trailing: Text(
                      S.common.labels.language,
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
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  _ListTile(
                    onTap: () => context.push(Routes.about),
                    icon: BoxIcons.bx_info_circle,
                    title: S.pages.settings.moreInformation.about,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(defaultRadius),
                      topRight: Radius.circular(defaultRadius),
                    ),
                  ),
                  _BuildVersionLabel(),
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
                S.pages.settings.dangerZone.title,
                style: style.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.red.withOpacity(.8),
                ),
              ),
            ),
            Card(
              color: Colors.red.withOpacity(.08),
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ListTile(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => RestoreAppDialog(
                    contextPreviousPage: context,
                  ),
                ),
                visualDensity: VisualDensity.compact,
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                leading: const Icon(BoxIcons.bx_reset),
                title: Text(S.pages.settings.dangerZone.restoreApp),
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
