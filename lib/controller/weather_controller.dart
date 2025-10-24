import 'package:get/get.dart';
import 'package:samatoll/controller/location_controller.dart';
import 'package:samatoll/model/weather.dart';
import 'package:samatoll/services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = Get.put(WeatherService());
  final LocationController _locationController = Get.put(LocationController());
  final RxBool isLoading = false.obs;
  Rx<Weather?> weather = Rx<Weather?>(null);

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
          {getWeatherInfos(),
          getForecastInfos()},
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
      print("the weather resp $resp");
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
      print("forecast resp ${resp}");
    } catch (e) {
      print('Une erreur est survenue forecast: $e');
      Get.snackbar('Erreur', "${e.toString()}");
    }
  }
}
