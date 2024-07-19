part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends MessageEvent {

  const SendMessageEvent({required this.messageEntity});
  final MessageEntity messageEntity;
}

class GetMessagesEvent extends MessageEvent {}
