import 'package:flutter/material.dart';

const double defaultPadding = 16.0;

class AppColors {
  static const Color card = Color(0xFF292A2C);
  static const Color background = Color(0xFF1F2022);
  static Color getTextColor(Color backgroundColor) {
    final double luminance = backgroundColor.computeLuminance();
    return luminance >= 0.34 ? Colors.black : Colors.white;
  }
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
