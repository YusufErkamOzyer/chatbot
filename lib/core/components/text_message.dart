import 'package:chatbot/core/color_constants.dart';
import 'package:chatbot/core/widgets/chat_bot_text.dart';
import 'package:flutter/material.dart';

enum SenderType { home, away }

class TextMessage extends StatelessWidget {
  final String data;
  final SenderType type;
  final String time;
  const TextMessage({
    super.key,
    this.data = "Hello from TextMessage widget!",
    required this.type,
    required this.time,
  });

  Color _getBackgroundColor(SenderType type) {
    switch (type) {
      case SenderType.home:
        return ColorPalette.appColor2;
      case SenderType.away:
        return ColorPalette.appColor4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: type == SenderType.home
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          width: 200,
          decoration: BoxDecoration(
            color: _getBackgroundColor(type),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatBotText(
                data: data,
                type: type == SenderType.home
                    ? MessageType.home
                    : MessageType.away,
              ),
              Align(
                alignment: Alignment.centerRight, // sadece time sağa hizalanır
                child: ChatBotText(data: time, type: MessageType.system),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
