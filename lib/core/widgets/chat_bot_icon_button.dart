import 'package:chatbot/core/color_constants.dart';
import 'package:flutter/material.dart';

class ChatBotIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const ChatBotIconButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Container(
        margin: EdgeInsets.only(left: 8.0),
        decoration: BoxDecoration(
          color: ColorPalette.appColor1,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: ColorPalette.appColor4, width: 2.0),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.send),
          iconSize: 24.0,
          color: ColorPalette.appColor4,
        ),
      ),
    );
  }
}
