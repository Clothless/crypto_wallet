import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  static String url = dotenv.env['METAMASK_HOST']!;
  static const String mediaType = 'application/json';
  static const String timeWindowWeek = '604800';
  static const String timeWindowDay = '86400';
  static String apiKey = dotenv.env['API_KEY']!;
  static const Duration connectTimeout = Duration(milliseconds: 20000);
  static const Duration receiveTimeout = Duration(milliseconds: 60000);
  static const Duration sendTimeout = Duration(milliseconds: 20000);
}
