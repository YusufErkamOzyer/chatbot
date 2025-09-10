import 'package:chatbot/app/screens/chat_event.dart';
import 'package:chatbot/app/screens/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _firestore = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>>? _messagesStream;
  ChatBloc() : super(ChatInitial()) {
    on<LoadMessages>(loadMessages);
    on<UpdateCurrentText>(updateCurrentText);
  }

  Future<void> loadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      _messagesStream = _firestore
          .collection('chats')
          .doc('HDzEaDTOYUMPIXukoIbT')
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
      await emit.forEach<List<Map<String, dynamic>>>(
        _messagesStream!,
        onData: (messages) => ChatSuccess(messages: messages),
        onError: (e, _) => ChatError(e.toString()),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void updateCurrentText(UpdateCurrentText event, Emitter<ChatState> emit) {
    if (state is ChatSuccess) {
      final currentState = state as ChatSuccess;
      emit(currentState.copyWith(currentText: event.currentText));
    }
  }
}
