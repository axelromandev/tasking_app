import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tasking/app/app.dart';
import 'package:tasking/config/config.dart';

import '../../../generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  static String routePath = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: SettingsPage Implement build method.

    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          S.of(context).settings_title,
          style: const TextStyle(color: Colors.white),
        ),
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
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.language, color: Colors.cyan),
                      title: Text(S.of(context).settings_general_language),
                      trailing: Text(
                        S.of(context).language == 'en'
                            ? S.of(context).language_en
                            : S.of(context).language_es,
                        style: style.bodyLarge,
                      ),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.color_lens, color: Colors.cyan),
                      title: Text(S.of(context).settings_general_theme),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading:
                          const Icon(Icons.notifications, color: Colors.cyan),
                      title: Text(S.of(context).settings_general_reminders),
                      trailing: const Icon(Icons.chevron_right),
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
                    ListTile(
                      onTap: () => context.push(AboutPage.routePath),
                      leading:
                          const Icon(BoxIcons.bx_crown, color: Colors.yellow),
                      title: Text(S.of(context).settings_about_app),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(BoxIcons.bx_info_circle,
                          color: Colors.yellow),
                      title: Text(S.of(context).about_version),
                      trailing: Text('1.0.0',
                          style: style.bodyLarge), //TODO: add version
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
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_shield,
                          color: Colors.greenAccent),
                      title: Text(S.of(context).settings_legal_privacy_policy),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_book_alt,
                          color: Colors.greenAccent),
                      title: Text(S.of(context).settings_legal_terms_of_use),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_book_open,
                          color: Colors.greenAccent),
                      title: Text(S.of(context).settings_legal_licenses),
                      trailing: const Icon(Icons.chevron_right),
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
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_star,
                          color: Colors.purpleAccent),
                      title: Text(S.of(context).settings_social_rate_app),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_share_alt,
                          color: Colors.purpleAccent),
                      title: Text(S.of(context).settings_social_share_app),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_message_square_detail,
                          color: Colors.purpleAccent),
                      title: Text(S.of(context).settings_social_feedback),
                      trailing: const Icon(Icons.chevron_right),
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
                    ListTile(
                      onTap: () {},
                      leading:
                          const Icon(BoxIcons.bx_envelope, color: Colors.white),
                      title: Text(S.of(context).settings_support_contact),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading:
                          const Icon(BoxIcons.bx_coffee, color: Colors.white),
                      title: Text(S.of(context).settings_support_coffee),
                      trailing: const Icon(Icons.chevron_right),
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
