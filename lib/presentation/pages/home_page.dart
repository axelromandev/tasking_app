import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String routePath = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: HomePage Implement build method.
    return const Scaffold(
      body: Center(child: Text('HomePage')),
    );
  }
}
