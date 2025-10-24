import 'package:get/get.dart';
import 'package:samatoll/services/location_service.dart';

class LocationController extends GetxController {
  final LocationService _locationService = Get.put(LocationService());
  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      final position = await _locationService.getCurrentPosition();
      print('Position : ${position.latitude} ${position.longitude}');
      currentLatitude.value = position.latitude;
      currentLongitude.value = position.longitude;
    } catch (e) {
      print('Une erreur est survenue : $e');
      Get.snackbar('Erreur', "${e.toString()}");
    } finally { 
      isLoading.value = false;
    }
  }
}
