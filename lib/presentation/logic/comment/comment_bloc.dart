import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../data/models/message/comment_model.dart';
import '../../../domain/entities/comment_entity.dart';
import '../../../domain/repositories/comment/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<GetCommentsEvent>(_mapGetCommentsEventToState);
    on<SendCommentEvent>(_mapSendCommentEventToState);
    on<SendMediaEvent>(_mapSendMediaEventToState);
    on<ListenCommentsEvent>(_mapListenCommentsEventToState);
  }

  final CommentRepository commentRepository;

  FutureOr<void> _mapGetCommentsEventToState(
      GetCommentsEvent event, Emitter<CommentState> emit) async {
    try {
      emit(CommentsLoading(state));
      final commentModels = await commentRepository.getComments(event.postId);
      final comments = commentModels.map((model) => CommentEntity.fromModel(model)).toList();
      emit(CommentsLoaded(comments));
    } catch (e) {
      emit(CommentsFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapSendCommentEventToState(
      SendCommentEvent event, Emitter<CommentState> emit) async {
    try {
      emit(CommentsLoading(state));
      await commentRepository.sendComment(event.postId, event.commentEntity);
    } catch (e) {
      emit(CommentsFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapSendMediaEventToState(
      SendMediaEvent event, Emitter<CommentState> emit) async {
    try {
      emit(CommentsLoading(state));
      await commentRepository.sendMedia(event.postId, event.file);
      emit(CommentSent(state, List.from(state.comments)));
    } catch (e) {
      emit(CommentsFailed(state, e.toString()));
    }
  }

  FutureOr<void> _mapListenCommentsEventToState(
      ListenCommentsEvent event, Emitter<CommentState> emit) async {
    try {
      await for (final DatabaseEvent addedEvent
          in commentRepository.onChildAdded(event.postId)) {
        if (state.initialDataLoaded) {
          final json = Map<String, dynamic>.from(
            addedEvent.snapshot.value! as Map<dynamic, dynamic>,
          )..addAll({'commentId': addedEvent.snapshot.key});
          final entity = CommentEntity.fromModel(
            CommentModel.fromJson(json),
          );
          emit(CommentSent(state, List.from(state.comments)..add(entity)));
        }
      }
    } catch (e) {
      emit(CommentsFailed(state, e.toString()));
    }
  }
}
