import 'package:chatbot/core/components/app_top_bar.dart';
import 'package:chatbot/core/components/text_message.dart';
import 'package:chatbot/core/components/text_sender.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(),
      bottomSheet: TextSender(controller: TextEditingController()),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[200]),
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [TextMessage(type: SenderType.home, time: "20:50")],
          ),
        ),
      ),
    );
  }
}
