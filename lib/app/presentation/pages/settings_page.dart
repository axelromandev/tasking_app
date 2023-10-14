import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  static String routePath = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: SettingsPage Implement build method.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextButton(
          onPressed: () => context.pop(),
          child: const Text('Volver'),
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('SettingsPage'),
      ),
    );
  }
}
