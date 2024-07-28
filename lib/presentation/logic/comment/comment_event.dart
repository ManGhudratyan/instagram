part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class SendCommentEvent extends CommentEvent {

  const SendCommentEvent({required this.postId, required this.commentEntity});
  final String postId;
  final CommentEntity commentEntity;
}


class GetCommentsEvent extends CommentEvent {
  const GetCommentsEvent({required this.postId});
  final String postId;

  @override
  List<Object> get props => [postId];
}

class ListenCommentsEvent extends CommentEvent {
  const ListenCommentsEvent({required this.postId});
  final String postId;

  @override
  List<Object> get props => [postId];
}

class SendMediaEvent extends CommentEvent {
  const SendMediaEvent({required this.postId, required this.file});
  final String postId;
  final File file;

  @override
  List<Object> get props => [postId, file];
}
