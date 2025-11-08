import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const weather_key = "2856e7ab04824adccbc9e70889df7502";
  static String get BACKEND_API => dotenv.env['BACKEND_API'] ?? '';
  static String get OPENAI_API_KEY => dotenv.env['OPENAI_API_KEY'] ?? '';
  static String get GEMINI_API_KEY => dotenv.env['GEMINI_API_KEY'] ?? '';
}
