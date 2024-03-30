import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasking/core/services/dotenv.dart';

class SupabaseService {
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: DotEnv.supabaseUrl,
        anonKey: DotEnv.supabaseAnonKey,
      );
    } catch (e) {
      log('Error', name: 'SupabaseService', error: e);
    }
  }
}
