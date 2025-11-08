import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationsController notificationsController = Get.put(
    NotificationsController(),
  );
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Alerte Secheresse',
      'message': 'Irrigation urgente necessaire en Zone B',
      'time': 'Il y a 2h',
      'type': 'warning',
      'read': false,
    },
    {
      'title': 'Pluie Prevue',
      'message': 'Pluies moderees prevues jeudi 12mm',
      'time': 'Il y a 5h',
      'type': 'info',
      'read': false,
    },
    {
      'title': 'Conditions Ideales',
      'message': 'Bon moment pour plantation de mil',
      'time': 'Hier',
      'type': 'success',
      'read': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notif = notifications[index];
        return _buildNotificationCard(notif);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    Color bgColor;
    Color iconColor;
    IconData icon;

    switch (notif['type']) {
      case 'warning':
        bgColor = Colors.red[50]!;
        iconColor = Colors.red[700]!;
        icon = Icons.warning_amber;
        break;
      case 'info':
        bgColor = Colors.blue[50]!;
        iconColor = Colors.blue[700]!;
        icon = Icons.info;
        break;
      case 'success':
        bgColor = Colors.green[50]!;
        iconColor = Colors.green[700]!;
        icon = Icons.check_circle;
        break;
      default:
        bgColor = Colors.grey[50]!;
        iconColor = Colors.grey[700]!;
        icon = Icons.notifications;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notif['read'] ? Colors.grey[100] : bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notif['read'] ? Colors.grey[300]! : iconColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  notif['message'],
                  style: TextStyle(color: Colors.grey[700]),
                ),
                SizedBox(height: 8),
                Text(
                  notif['time'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          if (!notif['read'])
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
