import 'package:chatbot/core/color_constants.dart';
import 'package:flutter/material.dart';

enum MessageType { home, away, system }

class ChatBotText extends StatelessWidget {
  final String data;
  final MessageType type;
  const ChatBotText({
    super.key,
    required this.data,
    this.type = MessageType.system,
  });

  Color _getTextColor(MessageType type) {
    switch (type) {
      case MessageType.home:
        return ColorPalette.appColor5;
      case MessageType.away:
        return ColorPalette.appColor1;
      case MessageType.system:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(data, style: TextStyle(color: _getTextColor(type)));
  }
}
