import 'package:flutter/material.dart';

const double defaultPadding = 16.0;

class AppColors {
  static const Color card = Color(0xFF21222D);
  static const Color background = Color(0xFF171821);
}

class StorageKeys {
  static String isFirstTime = 'isFirstTime';
  static String colorSeed = 'colorSeed';
}

class Assets {
  static const String _svg = 'assets/svg';
  static String logo = '$_svg/logo.svg';
}

class Urls {
  static String linkedin = 'https://www.linkedin.com/in/ingedevs';
  static String repo = 'https://github.com/ingedevs/tasking_app';
  static String privacyPolicy =
      'https://raw.githubusercontent.com/ingedevs/tasking_app/main/privacy-policy.md';
}

class Routes {
  static String intro = '/intro';
  static String home = '/';
  static String listTasks = '/list/:id';
  static String settings = '/settings';
  static String about = '/settings/about';
}
