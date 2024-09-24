import 'package:http/http.dart' as http;
import 'package:tasking/config/config.dart';

class MarkdownUtils {
  static Future<String> getFromUrl() async {
    final uri = Uri.parse(Urls.privacyPolicy);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('not found');
    }
  }
}
