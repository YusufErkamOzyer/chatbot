abstract class ChatEvent {}

class LoadMessages extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;
  final String sender;
  SendMessage(this.message, this.sender);
}
