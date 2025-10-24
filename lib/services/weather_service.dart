import 'dart:convert';

import 'package:get/get.dart';
import 'package:samatoll/const/app_constants.dart';
import 'package:samatoll/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService extends GetxService {
  final String _weatherKey = AppConstants.weather_key;
  Future<Map<String, dynamic>> fetchWeatherByLocation(
    double lat,
    double lng,
  ) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&appid=$_weatherKey&units=metric",
    );
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      return data;
    } else {
      throw Exception("Error calling weather api");
    }
  }

  Future<Map<String, dynamic>> fetchForecast(double lat, double lng) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lng}&appid=$_weatherKey&units=metric",
    );
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      return data;
    } else {
      throw Exception("Error calling forecast api");
    }
  }
}
