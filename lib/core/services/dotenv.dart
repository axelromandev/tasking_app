import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnv {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      log('Error', name: 'DotEnv', error: e);
    }
  }

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
