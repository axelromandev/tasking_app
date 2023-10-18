import 'package:flutter/material.dart';
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
                child: Text('General', style: style.headlineSmall),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.language, color: Colors.cyan),
                      title: const Text('Language'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('English', style: style.bodyLarge),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.color_lens, color: Colors.cyan),
                      title: const Text('Theme'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Light', style: style.bodyLarge),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading:
                          const Icon(Icons.notifications, color: Colors.cyan),
                      title: const Text('Reminders'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  'About',
                  style: style.headlineSmall,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading:
                          const Icon(BoxIcons.bx_crown, color: Colors.yellow),
                      title: const Text('About Tasking'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(BoxIcons.bx_info_circle,
                          color: Colors.yellow),
                      title: const Text('Version'),
                      trailing: Text('1.0.0', style: style.bodyLarge),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  'Legal',
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
                      title: const Text('Privacy Policy'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_book_alt,
                          color: Colors.greenAccent),
                      title: const Text('Terms of Service'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_book_open,
                          color: Colors.greenAccent),
                      title: const Text('Open Source Licenses'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: defaultPadding, left: 8),
                child: Text(
                  'Support',
                  style: style.headlineSmall,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_envelope,
                          color: Colors.purpleAccent),
                      title: const Text('Contact us'),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(BoxIcons.bx_coffee,
                          color: Colors.purpleAccent),
                      title: const Text('Buy me a coffee'),
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
                child: Text('Restore application',
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
