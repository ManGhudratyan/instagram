import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../data/models/comment/comment_model.dart';
import '../../../domain/entities/comment_entity.dart';
import '../../../domain/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<GetCommentsEvent>(_mapGetCommentsEventToState);
    on<SendCommentEvent>(_mapSendMessageEventToState);
    on<ListenCommentsEvent>(_mapListenCommentsEventToState);
  }
  final CommentRepository commentRepository;
  FutureOr<void> _mapGetCommentsEventToState(
      GetCommentsEvent event, Emitter<CommentState> emit) async {
    try {
      emit(CommentsLoading(state));
      final List<CommentEntity> comments =
          await commentRepository.getComments();
      emit(CommentsLoaded(comments));
    } catch (e) {
      emit(CommentsFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapSendMessageEventToState(
      SendCommentEvent event, Emitter<CommentState> emit) async {
    try {
      emit(CommentsLoading(state));
      await commentRepository.sendComment(event.commentEntity.toModel());
    } catch (e) {
      emit(CommentsFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapListenCommentsEventToState(
      ListenCommentsEvent event, Emitter<CommentState> emit) async {
    try {
      await for (final DatabaseEvent addedEvent
          in commentRepository.onChildAdded()) {
        if (state.initialDataLoaded) {
          final json = Map<String, dynamic>.from(
            addedEvent.snapshot.value! as Map<dynamic, dynamic>,
          )..addAll({'messageId': addedEvent.snapshot.key});
          final entity = CommentEntity.fromModel(
            CommentModel.fromJson(json),
          );
          emit(CommentsSent(state, List.from(state.comments)..add(entity)));
        }
      }
    } catch (e) {
      emit(CommentsFailed(state, e.toString()));
    }
  }
}
