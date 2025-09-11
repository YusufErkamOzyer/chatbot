import 'package:chatbot/app/screens/chat_bloc.dart';
import 'package:chatbot/app/screens/chat_event.dart';
import 'package:chatbot/app/screens/chat_state.dart';
import 'package:chatbot/core/components/app_top_bar.dart';
import 'package:chatbot/core/components/chatbot_loading.dart';
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
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (BuildContext context, ChatState state) {
          if (state is ChatSuccess) {
            final messages = state.messages;

            final groupedMessages = groupBy(messages, (msg) {
              final timestamp = msg['timestamp'] as Timestamp;
              final date = timestamp.toDate();
              return DateTime(date.year, date.month, date.day);
            });

            final sortedDates = groupedMessages.keys.toList()
              ..sort((a, b) => b.compareTo(a));

            print("Loading bool state is ${state.isLoading}");
            return Scaffold(
              appBar: AppTopBar(),
              bottomNavigationBar: SafeArea(
                child: TextSender(
                  onChanged: (value) {
                    context.read<ChatBloc>().add(UpdateCurrentText(value));
                  },
                  controller: TextEditingController(text: state.currentText),
                  onPressed: () {
                    context.read<ChatBloc>().add(
                      AddFirebaseMessage(state.currentText, "user"),
                    );
                    context.read<ChatBloc>().add(
                      SendMessageToChatbot(state.currentText),
                    );
                  },
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
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
                      ),
                      ChatbotLoading(isLoading: state.isLoading),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ChatLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ChatError) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else {
            return const Scaffold(body: Center(child: Text("Unknown state")));
          }
        },
      ),
    );
  }
}
