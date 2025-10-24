// lib/controllers/chat_controller.dart
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:samatoll/const/app_constants.dart';

class ChatController extends GetxController {
  final messages = <ChatMessage>[].obs;
  late final GenerativeModel model;

  final ChatUser currentUser = ChatUser(
    id: "1",
    firstName: "Mya",
    lastName: "Aidara",
  );

  final ChatUser aiUser = ChatUser(
    id: "2",
    firstName: "Gemini",
    lastName: "AI",
  );

  @override
  void onInit() {
    super.onInit();
    model = GenerativeModel(
      model: 'gemini-2.5-flash-lite',
      apiKey: AppConstants.GEMINI_API_KEY,
    );
  }

  Future<void> sendMessage(ChatMessage m) async {
    messages.insert(0, m);

    try {
      final history = messages.reversed.map((msg) {
        final role = msg.user == currentUser ? 'user' : 'model';
        return Content(role, [TextPart(msg.text)]);
      }).toList();

      final chat = model.startChat(history: history);
      final response = await chat.sendMessage(Content.text(m.text));

      messages.insert(
        0,
        ChatMessage(
          user: aiUser,
          createdAt: DateTime.now(),
          text: response.text ?? "No response",
        ),
      );
    } catch (e) {
      messages.insert(
        0,
        ChatMessage(
          user: aiUser,
          createdAt: DateTime.now(),
          text: "Sorry, I encountered an error: $e",
        ),
      );
    }
  }
}