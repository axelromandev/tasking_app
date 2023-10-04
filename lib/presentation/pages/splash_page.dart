import 'package:flutter/material.dart';
import 'package:tasking/presentation/widgets/logo.dart';

class SplashPage extends StatelessWidget {
  static String routePath = '/splash';

  const SplashPage({super.key});

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
