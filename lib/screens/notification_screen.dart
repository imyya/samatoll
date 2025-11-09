import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/notifications_controller.dart';
import 'package:samatoll/model/app_notification.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationsController controller = Get.put(NotificationsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.getNotifications(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.notifications.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Aucune notification',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.getNotifications(),
          child: ListView.builder(
            itemCount: controller.notifications.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];
              
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(notification.status),
                    child: Icon(
                      _getNotificationIcon(notification.notificationType),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    notification.message ?? 'Pas de message',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      if (notification.recipient != null)
                        Text(
                          'À: ${notification.recipient}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      if (notification.createdAt != null)
                        Text(
                          _formatDate(notification.createdAt!),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                  trailing: notification.status != null
                      ? Chip(
                          label: Text(
                            notification.status!,
                            style: const TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          backgroundColor: _getStatusColor(notification.status),
                        )
                      : null,
                  onTap: () => _showNotificationDetails(context, notification),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    
    switch (status.toLowerCase()) {
      case 'sent':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(String? type) {
    if (type == null) return Icons.message;
    
    switch (type.toLowerCase()) {
      case 'sms':
        return Icons.sms;
      case 'email':
        return Icons.email;
      case 'push':
        return Icons.notifications;
      default:
        return Icons.message;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return 'Il y a ${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Il y a ${difference.inHours} heure${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'Il y a ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'À l\'instant';
    }
  }

  void _showNotificationDetails(BuildContext context, AppNotification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          notification.notificationType?.toUpperCase() ?? 'NOTIFICATION',
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notification.message ?? 'Pas de message',
                style: const TextStyle(fontSize: 14),
              ),
              const Divider(height: 24),
              if (notification.recipient != null)
                _buildDetailRow('Destinataire', notification.recipient!),
              if (notification.status != null)
                _buildDetailRow('Statut', notification.status!),
              if (notification.notificationType != null)
                _buildDetailRow('Type', notification.notificationType!),
              if (notification.twilioSid != null)
                _buildDetailRow('Twilio SID', notification.twilioSid!),
              if (notification.createdAt != null)
                _buildDetailRow(
                  'Créé le',
                  _formatFullDate(notification.createdAt!),
                ),
              if (notification.sentAt != null)
                _buildDetailRow(
                  'Envoyé le',
                  _formatFullDate(notification.sentAt!),
                ),
              if (notification.errorMessage != null)
                _buildDetailRow(
                  'Erreur',
                  notification.errorMessage!,
                  isError: true,
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: isError ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatFullDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} à ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}