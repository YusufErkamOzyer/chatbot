import 'package:chatbot/core/widgets/chat_bot_icon_button.dart';
import 'package:chatbot/core/widgets/chat_bot_text_field.dart';
import 'package:flutter/material.dart';

class TextSender extends StatelessWidget {
  final VoidCallback? onPressed;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  const TextSender({
    super.key,
    this.onPressed,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ChatBotTextField(
              conroller: controller,
              onChanged: onChanged,
            ),
          ),
          ChatBotIconButton(onPressed: onPressed),
        ],
      ),
    );
  }
}
