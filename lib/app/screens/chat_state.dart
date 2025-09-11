abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Map<String, dynamic>> messages;
  final String currentText;
  final bool isLoading;
  ChatSuccess({
    required this.messages,
    this.currentText = "",
    this.isLoading = false,
  });

  ChatSuccess copyWith({
    List<Map<String, dynamic>>? messages,
    String? currentText,
    bool? isLoading,
  }) {
    return ChatSuccess(
      messages: messages ?? this.messages,
      currentText: currentText ?? this.currentText,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
