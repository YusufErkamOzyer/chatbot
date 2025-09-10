abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Map<String, dynamic>> messages;
  final String currentText;
  ChatSuccess({required this.messages, this.currentText = ""});

  ChatSuccess copyWith({
    List<Map<String, dynamic>>? messages,
    String? currentText,
  }) {
    return ChatSuccess(
      messages: messages ?? this.messages,
      currentText: currentText ?? this.currentText,
    );
  }
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
