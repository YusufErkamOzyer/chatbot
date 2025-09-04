import 'package:chatbot/core/widgets/chat_bot_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffD9D9D9),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () {
          SystemNavigator.pop();
        },
      ),
      title: const ChatBotText(data: "ChatBot", type: MessageType.system),
      centerTitle: true,
      actions: [
        SvgPicture.asset('assets/logo/chatbot.svg', width: 50, height: 50),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
