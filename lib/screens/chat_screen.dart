import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:samatoll/const/app_constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatUser _currentUser = ChatUser(
    id: "1",
    firstName: "Mya",
    lastName: "Aidara",
  );
  final ChatUser _gptChatUser = ChatUser(
    id: "2",
    firstName: "CHAT",
    lastName: "GPT ",
  );
  List<ChatMessage> _messages = <ChatMessage>[];

  final _openAI = OpenAI.instance.build(
    token: AppConstants.OPENAI_API_KEY,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: Text("SamaToll Agent", style: TextStyle(color: Colors.white)),
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
    List<Messages> _messageHistory =
        _messages.reversed.map((m) {
          if (m.user == _currentUser) {
            return Messages(role: Role.user, content: m.text);
          } else {
            return Messages(role: Role.assistant, content: m.text);
          }
        }).toList();
    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages:
          _messageHistory
              .map((m) => {"role": m.role.toString(), "content": m.content})
              .toList(),
      maxToken: 200,
    );
    final resp = await _openAI.onChatCompletion(request: request);
    for (var element in resp!.choices) {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _gptChatUser,
            createdAt: DateTime.now(),
            text: element.message!.content,
          ),
        );
      });
    }
  }
}
