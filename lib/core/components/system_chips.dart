import 'package:chatbot/core/widgets/chat_bot_text.dart';
import 'package:flutter/material.dart';

class SystemChips extends StatelessWidget {
  final String label;
  const SystemChips({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: ChatBotText(data: label, type: MessageType.system),
    );
  }
}
