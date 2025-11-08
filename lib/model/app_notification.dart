  class AppNotification {
    final int? id;
    final String? message;
    final String? recipient;
    final String? notificationType;
    final String? status;
    final String? twilioSid;
    final String? errorMessage;
    final DateTime? createdAt;
    final DateTime? sentAt;

    AppNotification({
      this.id,
      this.message,
      this.recipient,
      this.notificationType,
      this.status,
      this.twilioSid,
      this.errorMessage,
      this.createdAt,
      this.sentAt,
    });

    factory AppNotification.fromJson(Map<String, dynamic> json) {
      int? parseId(dynamic v) {
        if (v == null) return null;
        if (v is int) return v;
        return int.tryParse(v.toString());
      }

      DateTime? parseDate(dynamic v) {
        if (v == null) return null;
        try {
          return DateTime.parse(v.toString());
        } catch (_) {
          return null;
        }
      }

      return AppNotification(
        id: parseId(json['id']),
        message: json['message']?.toString(),
        recipient: json['recipient']?.toString(),
        notificationType: json['notification_type']?.toString(),
        status: json['status']?.toString(),
        twilioSid: json['twilio_sid']?.toString(),
        errorMessage: json['error_message']?.toString(),
        createdAt: parseDate(json['created_at']),
        sentAt: parseDate(json['sent_at']),
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'message': message,
        'recipient': recipient,
        'notification_type': notificationType,
        'status': status,
        'twilio_sid': twilioSid,
        'error_message': errorMessage,
        'created_at': createdAt?.toIso8601String(),
        'sent_at': sentAt?.toIso8601String(),
      };
    }

    static List<AppNotification> listFromJson(dynamic jsonList) {
      if (jsonList is! List) return [];
      return jsonList
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    AppNotification copyWith({
      int? id,
      String? message,
      String? recipient,
      String? notificationType,
      String? status,
      String? twilioSid,
      String? errorMessage,
      DateTime? createdAt,
      DateTime? sentAt,
    }) {
      return AppNotification(
        id: id ?? this.id,
        message: message ?? this.message,
        recipient: recipient ?? this.recipient,
        notificationType: notificationType ?? this.notificationType,
        status: status ?? this.status,
        twilioSid: twilioSid ?? this.twilioSid,
        errorMessage: errorMessage ?? this.errorMessage,
        createdAt: createdAt ?? this.createdAt,
        sentAt: sentAt ?? this.sentAt,
      );
    }
  }