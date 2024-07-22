part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}
class SendMessageEvent extends ChatEvent {

  const SendMessageEvent({
    required this.senderId,
    required this.recipientId,
    required this.message,
  });
  final String senderId;
  final String recipientId;
  final String message;

  @override
  List<Object> get props => [senderId, recipientId, message];
}

class LoadMessagesEvent extends ChatEvent {

  const LoadMessagesEvent({
    required this.senderId,
    required this.recipientId,
  });
  final String senderId;
  final String recipientId;

  @override
  List<Object> get props => [senderId, recipientId];
}

class MessagesUpdatedEvent extends ChatEvent {

  const MessagesUpdatedEvent({required this.messages});
  final List<Map<String, dynamic>> messages;

  @override
  List<Object> get props => [messages];
}
