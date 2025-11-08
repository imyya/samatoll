import 'dart:convert';

import 'package:get/get.dart';
import 'package:samatoll/const/app_constants.dart';
import 'package:http/http.dart' as http;

class NotificationService extends GetxService {
  final apiUrl = AppConstants.BACKEND_API;
    Future<Map<String, dynamic>> fetchNotifications(
  ) async {
    final url = Uri.parse(
     "$apiUrl/notifications",
    );
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      return data;
    } else {
      throw Exception("Error calling backend notifications api");
    }
  }
}
