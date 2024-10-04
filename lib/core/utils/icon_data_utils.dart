import 'dart:convert';

import 'package:flutter/widgets.dart';

class IconDataUtils {
  static IconData decode(String jsonEncode) {
    final jsonDecode = json.decode(jsonEncode) as Map<String, dynamic>;
    return IconData(
      jsonDecode['codePoint'] as int,
      fontFamily: jsonDecode['fontFamily'] as String,
      fontPackage: jsonDecode['fontPackage'] as String,
    );
  }

  static String encode(IconData icon) {
    return json.encode({
      'codePoint': icon.codePoint,
      'fontFamily': icon.fontFamily,
      'fontPackage': icon.fontPackage,
    });
  }
}
