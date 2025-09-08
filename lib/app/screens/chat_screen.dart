import 'package:chatbot/core/components/app_top_bar.dart';
import 'package:chatbot/core/components/system_chips.dart';
import 'package:chatbot/core/components/text_message.dart';
import 'package:chatbot/core/components/text_sender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Future<void> fetchMessages() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('chats')
        .doc('HDzEaDTOYUMPIXukoIbT')
        .collection('messages')
        .orderBy('timestamp')
        .get();

    for (var doc in snapshot.docs) {
      print(doc.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(),
      bottomSheet: TextSender(controller: TextEditingController()),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.grey[200]),
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .doc('HDzEaDTOYUMPIXukoIbT')
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('No messages found.');
              }

              final messages = snapshot.data!.docs;

              return ListView.builder(
                reverse: true,
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SystemChips(label: 'Bugün');
                  }
                  final message = messages[index - 1];
                  final data = message.data() as Map<String, dynamic>;

                  return TextMessage(
                    data: data['message'] ?? '',
                    type: SenderType.home,
                    time: '',
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
