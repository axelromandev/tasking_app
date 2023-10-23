import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../widgets/widgets.dart';

class RemindersPage extends StatelessWidget {
  static String routePath = '/reminders';

  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: RemindersPage Implement build method.

    final style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTitle('Reminders'),
            Text(
              'Your reminders will appear here.',
              style: style.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
