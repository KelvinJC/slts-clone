import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  /// Pulls API_BASE from your .env file
  static String get apiBase {
    final value = dotenv.env['API_BASE'];
    if (value == null) {
      throw Exception('API_BASE is not set in .env');
    }
    return value;
  }

  static String get violationFileUrl {
    return '${Env.apiBase}/public/upload';
  }
}
