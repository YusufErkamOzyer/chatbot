import 'package:chatbot/app/screens/chat_bloc.dart';
import 'package:chatbot/app/screens/chat_event.dart';
import 'package:chatbot/app/screens/chat_state.dart';
import 'package:chatbot/core/components/app_top_bar.dart';
import 'package:chatbot/core/components/system_chips.dart';
import 'package:chatbot/core/components/text_message.dart';
import 'package:chatbot/core/components/text_sender.dart';
import 'package:chatbot/core/service/chatbot_service.dart';
import 'package:chatbot/core/utils/timestamp_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
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
          child: TextSender(
            controller: TextEditingController(),
            onPressed: () async {
              final res = await ChatbotService().sendMessage("Merhaba");
              if (res != null) {
                if (kDebugMode) {
                  print(res.response);
                  print(res.intents);
                }
              }
            },
          ),
        ),
        body: Center(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (BuildContext context, state) {
              if (state is ChatLoading) {
                return const CircularProgressIndicator();
              } else if (state is ChatSuccess) {
                final messages = state.messages;

                final groupedMessages = groupBy(messages, (msg) {
                  final timestamp = msg['timestamp'] as Timestamp;
                  final date = timestamp.toDate();
                  return DateTime(date.year, date.month, date.day);
                });

                final sortedDates = groupedMessages.keys.toList()
                  ..sort((a, b) => b.compareTo(a));

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    reverse: true,
                    children: sortedDates.expand((date) {
                      final msgs = groupedMessages[date]!;

                      return [
                        ...msgs.map((msg) {
                          final sender = msg['sender'] == "user"
                              ? SenderType.home
                              : SenderType.away;
                          final text = msg['message'];
                          final timestamp = msg['timestamp'] as Timestamp;
                          final time = TimestampUtil.formatTimestampHour(
                            timestamp,
                          );
                          // final date = timestamp.toDate();
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextMessage(
                              type: sender,
                              time: time,
                              data: text,
                            ),
                          );
                        }),
                        Center(
                          child: SystemChips(
                            label: TimestampUtil.formatDate(date),
                          ),
                        ),
                      ];
                    }).toList(),
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
