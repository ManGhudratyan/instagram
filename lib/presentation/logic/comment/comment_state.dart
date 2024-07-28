part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState({
    this.error,
    this.comments = const [],
    this.initialDataLoaded = false,
  });

  final String? error;
  final List<CommentEntity> comments;
  final bool initialDataLoaded;

  @override
  List<Object?> get props => [error, comments];
}

final class CommentInitial extends CommentState {}

final class CommentsInitial extends CommentState {}

final class CommentsLoading extends CommentState {
  CommentsLoading(CommentState initState)
      : super(
          comments: initState.comments,
          initialDataLoaded: initState.initialDataLoaded,
        );
}

final class CommentsFailed extends CommentState {
  CommentsFailed(CommentState initState, String error)
      : super(
          error: error,
          initialDataLoaded: initState.initialDataLoaded,
        );
}

final class CommentsLoaded extends CommentState {
  const CommentsLoaded(List<CommentEntity> comments)
      : super(comments: comments, initialDataLoaded: true);
}

final class CommentSent extends CommentState {
  CommentSent(CommentState initState, List<CommentEntity> comments)
      : super(
          comments: comments,
          initialDataLoaded: initState.initialDataLoaded,
        );
}
