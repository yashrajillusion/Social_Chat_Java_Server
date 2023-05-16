import 'package:chat_app/ui/common/input_text_field/input_text_field.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_message_tile.dart';
import 'package:chat_app/ui/screens/chat_screen/commons/chat_screen_appbar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2EDF5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFE2EDF5),
        elevation: 0,
        title: const ChatScreenAppbar(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: datat.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: datat.length - 1 == index ? const EdgeInsets.only(bottom: 50) : EdgeInsets.zero,
                  child:
                      ChatMessageTile(message: datat[index]['message'], isSent: datat[index]['sent'], date: datat[index]['time']),
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                color: const Color(0xFFE2EDF5),
                child: const InputTextField(
                  hintText: "Type here...",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List datat = [
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": false,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": false,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": false,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": false,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": false,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": false,
    "time": "today",
  },
  {
    "message": "how are u?",
    "sent": true,
    "time": "today",
  },
];
