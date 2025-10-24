import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:samatoll/controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      body: Obx(() => DashChat(
        currentUser: controller.currentUser,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Color.fromARGB(95, 29, 27, 27),
          containerColor: Colors.green,
          textColor: Colors.white,
        ),
        onSend: (ChatMessage m) {
          controller.sendMessage(m);
        },
        messages: controller.messages.value,
      )),
    );
  }
}