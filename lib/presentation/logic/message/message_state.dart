part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState(
      {this.error, this.messages = const [], this.initialDataLoaded = false});

  final String? error;
  final List<MessageEntity> messages;
  final bool initialDataLoaded;
  @override
  List<Object?> get props => [messages, initialDataLoaded, error];
}

final class MessageInitial extends MessageState {}

final class MessagesLoading extends MessageState {
  MessagesLoading(MessageState initState)
      : super(
          messages: initState.messages,
          initialDataLoaded: initState.initialDataLoaded,
        );
}

final class MessagesFailed extends MessageState {
  MessagesFailed(MessageState initState, String error)
      : super(error: error, initialDataLoaded: initState.initialDataLoaded);
}

final class MessagesLoaded extends MessageState {
  const MessagesLoaded(List<MessageEntity> messages)
      : super(messages: messages, initialDataLoaded: true);
}

final class MessageSent extends MessageState {
  MessageSent(MessageState initState, List<MessageEntity> messages)
      : super(
            messages: messages, initialDataLoaded: initState.initialDataLoaded);
}
