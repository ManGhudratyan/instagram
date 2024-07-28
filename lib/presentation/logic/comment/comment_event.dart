part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class SendCommentEvent extends CommentEvent {
  const SendCommentEvent({required this.commentEntity});
  final CommentEntity commentEntity;
}

class GetCommentsEvent extends CommentEvent {}

class ListenCommentsEvent extends CommentEvent {}

class SendMediaEvent extends CommentEvent {
  const SendMediaEvent({required this.file});

  final File file;
}
