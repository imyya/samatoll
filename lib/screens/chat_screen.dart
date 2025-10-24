import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:samatoll/const/app_constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final GenerativeModel _model;

  final ChatUser _currentUser = ChatUser(
    id: "1",
    firstName: "Mya",
    lastName: "Aidara",
  );
  
  final ChatUser _gptChatUser = ChatUser(
    id: "2",
    firstName: "Gemini",
    lastName: "AI",
  );
  
  List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite',
      apiKey: AppConstants.GEMINI_API_KEY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: const Text("SamaToll Agent", style: TextStyle(color: Colors.white)),
      // ),
      body: DashChat(
        currentUser: _currentUser,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Color.fromARGB(95, 29, 27, 27),
          containerColor: Colors.green,
          textColor: Colors.white,
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
    });

    try {
      // Build conversation history
      final history = _messages.reversed.map((msg) {
        final role = msg.user == _currentUser ? 'user' : 'model';
        return Content(role, [TextPart(msg.text)]);
      }).toList();

      // Start chat with history
      final chat = _model.startChat(history: history);
      
      // Send message
      final response = await chat.sendMessage(Content.text(m.text));
      
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: response.text ?? "No response",
          ),
        );
      });
    } catch (e) {
      print('Error: $e');
      // Show error message to user
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: "Sorry, I encountered an error: $e",
          ),
        );
      });
    }
  }
}