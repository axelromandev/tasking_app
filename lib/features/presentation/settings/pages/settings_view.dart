import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tasking/config/config.dart';
import 'package:tasking/i18n/i18n.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;
    final colorPrimary = ref.watch(colorThemeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(IconsaxOutline.arrow_left_2),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(IconsaxOutline.setting, color: colorPrimary),
            const Gap(12),
            Text(
              S.features.settings.title,
              style: style.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: true,
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
                S.features.settings.page.general.title,
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
                    onTap: () => context.push('/settings/backup'),
                    icon: IconsaxOutline.refresh,
                    title: S.features.settings.page.general.backup,
                    borderRadius: BorderRadius.circular(16),
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
                S.features.settings.page.appearance.title,
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
                    onTap: () => context.push('/settings/themes'),
                    icon: IconsaxOutline.color_swatch,
                    title: S.features.settings.page.appearance.theme,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  _ListTile(
                    onTap: () => context.push('/settings/language'),
                    icon: IconsaxOutline.language_square,
                    title: S.features.settings.page.appearance.language,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
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
                S.features.settings.page.moreInformation.title,
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
                    onTap: () => context.push('/settings/about'),
                    icon: IconsaxOutline.info_circle,
                    title: S.features.settings.page.moreInformation.about,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  _ListTile(
                    onTap: () => launchUrlString(Urls.privacyPolicy),
                    icon: IconsaxOutline.shield,
                    title: S
                        .features.settings.page.moreInformation.privacyPolicies,
                  ),
                  _ListTile(
                    onTap: () => Share.shareUri(
                      Uri.parse(Urls.appStoreUrl),
                    ),
                    icon: IconsaxOutline.share,
                    title: S.features.settings.page.moreInformation.share,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(defaultPadding),
            _BuildVersionLabel(),
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(
          'Version $version ($buildNumber)',
          style: style.bodySmall?.copyWith(color: Colors.white38),
        ),
      ),
    );
  }
}
