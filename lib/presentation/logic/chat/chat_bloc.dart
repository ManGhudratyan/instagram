import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/repositories/chat/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<SendMessageEvent>(_mapSendMessageEventToState);
    on<LoadMessagesEvent>(_mapLoadMessagesEventToState);
    on<MessagesUpdatedEvent>(_mapMessagesUpdatedEventToState);
  }

  final ChatRepository chatRepository;
  StreamSubscription<List<Map<String, dynamic>>>? _messagesSubscription;

  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      await chatRepository.sendMessage(
          event.senderId, event.recipientId, event.message);
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  FutureOr<void> _mapLoadMessagesEventToState(
      LoadMessagesEvent event, Emitter<ChatState> emit) {
    emit(ChatLoading());
    _messagesSubscription?.cancel();
    _messagesSubscription =
        chatRepository.getMessages(event.senderId, event.recipientId).listen(
      (messages) {
        add(MessagesUpdatedEvent(messages: messages));
      },
      onError: (error) {
        emit(ChatError(message: error.toString()));
      },
    );
  }

  FutureOr<void> _mapMessagesUpdatedEventToState(
      MessagesUpdatedEvent event, Emitter<ChatState> emit) {
    emit(ChatLoaded(messages : event.messages));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
