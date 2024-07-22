part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  const ChatLoaded({required this.messages});
  final List<Map<String, dynamic>> messages;

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatState {
  const ChatError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
