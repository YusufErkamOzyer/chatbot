import 'package:chatbot/core/color_constants.dart';
import 'package:flutter/material.dart';

class ChatBotTextField extends StatelessWidget {
  final TextEditingController conroller;
  final ValueChanged<String>? onChanged;
  const ChatBotTextField({super.key, required this.conroller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: conroller,
      decoration: InputDecoration(
        fillColor: ColorPalette.appColor1,
        filled: true,
        focusColor: ColorPalette.appColor4,

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: ColorPalette.appColor4, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: ColorPalette.appColor4, width: 2.0),
        ),

        hintText: 'Type your message...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: ColorPalette.appColor4, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}
