import 'package:flutter/services.dart';

class Markdown {
  static Future<String> getFromFile() async {
    final String content = await rootBundle.loadString('privacy-policy.md');
    return content;
  }
}
