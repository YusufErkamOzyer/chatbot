import 'package:chatbot/app/screens/chat_event.dart';
import 'package:chatbot/app/screens/chat_state.dart';
import 'package:chatbot/core/service/chatbot_service.dart';
import 'package:chatbot/core/service/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  Stream<List<Map<String, dynamic>>>? _messagesStream;
  ChatBloc() : super(ChatInitial()) {
    on<LoadMessages>(loadMessages);
    on<UpdateCurrentText>(updateCurrentText);
    on<AddFirebaseMessage>(addNewMessage);
    on<SendMessageToChatbot>(sendMessageToChatbot);
  }

  Future<void> loadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      _messagesStream = FirebaseService().getMessagesStream();
      await emit.forEach<List<Map<String, dynamic>>>(
        _messagesStream!,
        onData: (messages) => ChatSuccess(messages: messages),
        onError: (e, _) => ChatError(e.toString()),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> addNewMessage(
    AddFirebaseMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (event.text.trim().isEmpty) return;

    try {
      await FirebaseService().addNewMessage(event.text, event.sender);
      if (state is ChatSuccess) {
        final currentState = state as ChatSuccess;
        emit(currentState.copyWith(currentText: ""));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> sendMessageToChatbot(
    SendMessageToChatbot event,
    Emitter<ChatState> emit,
  ) async {
    if (event.message.trim().isEmpty) return;

    try {
      final response = await ChatbotService().sendMessage(event.message);
      await FirebaseService().addNewMessage(response!.response, "bot");
      if (state is ChatSuccess) {
        final currentState = state as ChatSuccess;
        emit(currentState.copyWith(currentText: ""));
      }
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
