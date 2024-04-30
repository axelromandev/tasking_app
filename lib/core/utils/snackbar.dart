import 'package:flutter/material.dart';

import '../../config/config.dart';

enum SnackBarType { info, success, error, warning }

class Snackbar {
  static final BuildContext _context = navigatorGlobalKey.currentContext!;

  static void custom(
    String message, {
    Color? textColor,
    Color? backgroundColor,
  }) {
    final isDarkMode = Theme.of(_context).brightness == Brightness.dark;

    ScaffoldMessenger.of(_context).hideCurrentSnackBar();
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor ?? (isDarkMode ? Colors.black : Colors.white),
            )),
        backgroundColor:
            backgroundColor ?? (isDarkMode ? Colors.white : Colors.black),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
    );
  }

  static void show(String message, {SnackBarType type = SnackBarType.info}) {
    ScaffoldMessenger.of(_context).hideCurrentSnackBar();
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getTextColor(type),
            )),
        backgroundColor: _getBackgroundColor(type),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      ),
    );
  }

  static Color _getTextColor(SnackBarType type) {
    final isDarkMode = Theme.of(_context).brightness == Brightness.dark;

    return switch (type) {
      SnackBarType.info => isDarkMode ? Colors.black : Colors.white,
      SnackBarType.success => Colors.white,
      SnackBarType.error => Colors.white,
      SnackBarType.warning => Colors.black
    };
  }

  static Color _getBackgroundColor(SnackBarType type) {
    final isDarkMode = Theme.of(_context).brightness == Brightness.dark;

    return switch (type) {
      SnackBarType.info => isDarkMode ? Colors.white : Colors.black,
      SnackBarType.success => Colors.green,
      SnackBarType.error => Colors.red,
      SnackBarType.warning => Colors.yellow
    };
  }
}
