import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get apiUrl => dotenv.env['API_URL'] ?? '192.168.1.6:8080';
}
