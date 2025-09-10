class ChatbotResponse {
  final String response;
  final List<dynamic> intents;

  ChatbotResponse({required this.response, required this.intents});

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotResponse(
      response: json['response'],
      intents: json['intents'],
    );
  }
}
