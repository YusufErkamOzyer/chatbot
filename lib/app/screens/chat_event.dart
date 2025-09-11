abstract class ChatEvent {}

class LoadMessages extends ChatEvent {}

class SendMessageToChatbot extends ChatEvent {
  final String message;
  SendMessageToChatbot(this.message);
}

class UpdateCurrentText extends ChatEvent {
  final String currentText;
  UpdateCurrentText(this.currentText);
}

class AddFirebaseMessage extends ChatEvent {
  final String text;
  final String sender;

  AddFirebaseMessage(this.text, this.sender);
}
