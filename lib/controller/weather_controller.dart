import 'package:get/get.dart';
import 'package:samatoll/controller/location_controller.dart';
import 'package:samatoll/model/forecast_weather.dart';
import 'package:samatoll/model/weather.dart';
import 'package:samatoll/services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = Get.put(WeatherService());
  final LocationController _locationController = Get.put(LocationController());
  final RxBool isLoading = false.obs;
  Rx<Weather?> weather = Rx<Weather?>(null);
  Rx<WeatherForecast?> forecast = Rx<WeatherForecast?>(null);

  @override
  void onInit() {
    super.onInit();
    everAll(
      ([
        _locationController.currentLatitude,
        _locationController.currentLongitude,
      ]),
      (_) => {
        if (_locationController.currentLatitude.value != 0.0 &&
            _locationController.currentLongitude.value != 0.0)
          {getWeatherInfos(), getForecastInfos()},
      },
    );
  }

  Future<void> getWeatherInfos() async {
    try {
      isLoading.value = true;
      final lat = _locationController.currentLatitude.value;
      //  != 0.0
      //     ? _locationController.currentLatitude.value
      //     : 14.7167;
      final lng = _locationController.currentLongitude.value;
      //  != 0.0
      //     ? _locationController.currentLongitude.value
      //     : -17.4677;
      final resp = await _weatherService.fetchWeatherByLocation(lat, lng);
      weather.value = Weather.fromJson(resp);
      //print("the weather resp $resp");
    } catch (e) {
      print('Une erreur est survenue : $e');
      Get.snackbar('Erreur', "${e.toString()}");
    }
  }

  Future<void> getForecastInfos() async {
    try {
      isLoading.value = true;
      final lat = _locationController.currentLatitude.value;
      //  != 0.0
      //     ? _locationController.currentLatitude.value
      //     : 14.7167;
      final lng = _locationController.currentLongitude.value;
      //  != 0.0
      //     ? _locationController.currentLongitude.value
      //     : -17.4677;
      final resp = await _weatherService.fetchForecast(lat, lng);
      //  weather.value = Weather.fromJson(resp);
      forecast.value = WeatherForecast.fromJson(resp);
      print("forecast resp ${resp}");
    } catch (e) {
      print('Une erreur est survenue forecast: $e');
      Get.snackbar('Erreur', "${e.toString()}");
    }
  }


    // Obtenir les prévisions groupées par jour (max 5 jours)
  Map<String, List<ForecastItem>> get forecastByDay {
    if (forecast.value == null) return {};
    
    Map<String, List<ForecastItem>> grouped = {};
    for (var item in forecast.value!.list) {
      final dateKey = item.formattedDate;
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(item);
    }
    return grouped;
  }

  // Obtenir les prévisions des prochaines 24h (8 points de données)
  List<ForecastItem> get next24Hours {
    if (forecast.value == null) return [];
    return forecast.value!.list.take(8).toList();
  }

  // Obtenir les prévisions des 5 prochains jours (une par jour à midi)
  List<ForecastItem> get next5DaysAtNoon {
    if (forecast.value == null) return [];
    
    final Map<String, ForecastItem> dailyForecasts = {};
    
    for (var item in forecast.value!.list) {
      final dateKey = item.formattedDate;
      final hour = item.dateTime.hour;
      
      // Prendre la prévision la plus proche de midi (12h)
      if (!dailyForecasts.containsKey(dateKey) || 
          (hour >= 12 && hour < 15)) {
        dailyForecasts[dateKey] = item;
      }
    }
    
    return dailyForecasts.values.take(5).toList();
  }

  // Température moyenne par jour
  Map<String, double> get avgTempByDay {
    Map<String, double> result = {};
    forecastByDay.forEach((day, items) {
      double sum = items.fold(0, (prev, item) => prev + item.main.temp);
      result[day] = sum / items.length;
    });
    return result;
  }

  // Température max/min par jour
  Map<String, Map<String, double>> get tempRangeByDay {
    Map<String, Map<String, double>> result = {};
    forecastByDay.forEach((day, items) {
      double max = items.map((e) => e.main.tempMax).reduce((a, b) => a > b ? a : b);
      double min = items.map((e) => e.main.tempMin).reduce((a, b) => a < b ? a : b);
      result[day] = {'max': max, 'min': min};
    });
    return result;
  }

  // Probabilité de pluie maximale par jour
  Map<String, double> get maxRainProbByDay {
    Map<String, double> result = {};
    forecastByDay.forEach((day, items) {
      double maxProb = items.map((e) => e.pop).reduce((a, b) => a > b ? a : b);
      result[day] = maxProb * 100; // Convertir en pourcentage
    });
    return result;
  }

  // Volume total de pluie par jour
  Map<String, double> get totalRainByDay {
    Map<String, double> result = {};
    forecastByDay.forEach((day, items) {
      double total = items.fold(0.0, (prev, item) => 
        prev + (item.rain?.threeHour ?? 0));
      result[day] = total;
    });
    return result;
  }

  // Vitesse moyenne du vent par jour
  Map<String, double> get avgWindSpeedByDay {
    Map<String, double> result = {};
    forecastByDay.forEach((day, items) {
      double sum = items.fold(0, (prev, item) => prev + item.wind.speed);
      result[day] = sum / items.length;
    });
    return result;
  }

  // Humidité moyenne par jour
  Map<String, double> get avgHumidityByDay {
    Map<String, double> result = {};
    forecastByDay.forEach((day, items) {
      double sum = items.fold(0.0, (prev, item) => prev + item.main.humidity);
      result[day] = sum / items.length;
    });
    return result;
  }

  // Vérifier si conditions bonnes pour pulvérisation (vent < 7 m/s, pas de pluie)
  Map<String, bool> get sprayingConditionsByDay {
    Map<String, bool> result = {};
    forecastByDay.forEach((day, items) {
      bool goodConditions = items.any((item) => 
        item.wind.speed < 7 && item.pop < 0.3);
      result[day] = goodConditions;
    });
    return result;
  }
}
