import 'dart:convert';

import 'package:chatbot/core/service/chatbot_response.dart';
import 'package:http/http.dart' as http;

class ChatbotService {
  Future<ChatbotResponse?> sendMessage(String message) async {
    final url = Uri.parse(
      "https://mychatbot-405249899656.europe-west3.run.app/predict",
    );
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message}),
    );

    if (response.statusCode == 200) {
      return ChatbotResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
