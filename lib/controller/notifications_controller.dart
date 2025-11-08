import 'package:get/get.dart';
import 'package:samatoll/model/app_notification.dart';
import 'package:samatoll/services/notification_service.dart';

class NotificationsController extends GetxController {
  final NotificationService _notificationService = Get.put(
    NotificationService(),
  );
  final RxList<AppNotification> notifications = <AppNotification>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications() async {
    try {
      isLoading.value = true;
      final resp = await _notificationService.fetchNotifications();
      final dynamic source =
          resp is List ? resp : (resp?['notifications'] ?? []);
      notifications.value = AppNotification.listFromJson(source);
      print("the notifs $resp");
    } catch (e) {
      print('Une erreur est survenue : $e');
      Get.snackbar('Erreur', "${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
