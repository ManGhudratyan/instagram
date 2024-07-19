import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(this.messageRepository) : super(MessageInitial()) {
    on<GetMessagesEvent>(_mapGetMessagesEventToState);
    on<SendMessageEvent>(_mapSendMessageEventToState);
  }

  final MessageRepository messageRepository;
  FutureOr<void> _mapGetMessagesEventToState(
      GetMessagesEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessagesLoading(state));
      final List<MessageEntity> messages =
          await messageRepository.getMessages();
      emit(MessagesLoaded(messages));
    } catch (e) {
      emit(MessagesFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapSendMessageEventToState(
      SendMessageEvent event, Emitter<MessageState> emit) async {
    try {
      emit(MessagesLoading(state));
      await messageRepository.sendMessage(event.messageEntity.toModel());
    } catch (e) {
      emit(MessagesFailed(state, e.toString()));
    }
  }
}
