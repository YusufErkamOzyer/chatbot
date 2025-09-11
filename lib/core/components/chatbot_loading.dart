import 'package:chatbot/core/color_constants.dart';
import 'package:chatbot/core/widgets/chat_bot_text.dart';
import 'package:flutter/material.dart';

class ChatbotLoading extends StatelessWidget {
  final bool isLoading;
  const ChatbotLoading({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: ColorPalette.appColor5,
            ),
            width: double.infinity,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: ColorPalette.appColor1,
                  ),
                ),
                SizedBox(width: 16.0),
                ChatBotText(data: "Loading...", type: MessageType.away),
              ],
            ),
          )
        : SizedBox();
  }
}
