import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  static String routePath = '/reminders';

  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: RemindersPage Implement build method.
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('RemindersPage'),
      ),
    );
  }
}
