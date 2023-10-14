import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class IntroPage extends StatelessWidget {
  static String routePath = '/intro';

  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: const Center(child: Logo()),
      ),
    );
  }
}
