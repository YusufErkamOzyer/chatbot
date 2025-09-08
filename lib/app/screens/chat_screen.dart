import 'package:chatbot/app/screens/chat_bloc.dart';
import 'package:chatbot/app/screens/chat_event.dart';
import 'package:chatbot/app/screens/chat_state.dart';
import 'package:chatbot/core/components/app_top_bar.dart';
import 'package:chatbot/core/components/system_chips.dart';
import 'package:chatbot/core/components/text_message.dart';
import 'package:chatbot/core/components/text_sender.dart';
import 'package:chatbot/core/utils/timestamp_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc()..add(LoadMessages()),
      child: Scaffold(
        appBar: AppTopBar(),
        bottomNavigationBar: SafeArea(
          child: TextSender(controller: TextEditingController()),
        ),
        body: Center(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (BuildContext context, state) {
              if (state is ChatLoading) {
                return const CircularProgressIndicator();
              } else if (state is ChatSuccess) {
                final message = state.messages;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      final msg = message[index];
                      final sender = msg['sender'] == "user"
                          ? SenderType.home
                          : SenderType.away;
                      final text = msg['message'];
                      final timestamp = msg['timestamp'] as Timestamp?;
                      final time = TimestampUtil.formatTimestampHour(
                        timestamp!,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextMessage(
                          type: sender,
                          time: time,
                          data: text,
                        ),
                      );
                    },
                  ),
                );
              } else if (state is ChatError) {
                return Text('Error: ${state.message}');
              }
              return const Text('Press button to load messages');
            },
          ),
        ),
      ),
    );
  }
}
