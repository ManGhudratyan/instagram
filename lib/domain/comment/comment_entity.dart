import '../../data/models/message/comment_model.dart';

class CommentEntity {
  CommentEntity({
    this.userId,
    this.comment,
    this.dateTime,
    this.commentId,
    this.postId,
    this.username,
  });

  factory CommentEntity.fromModel(CommentModel model) => CommentEntity(
        userId: model.userId,
        comment: model.comment,
        dateTime: model.dateTime,
        commentId: model.commentId,
        postId: model.postId,
        username: model.username,
      );
  final String? userId;
  final String? comment;
  final DateTime? dateTime;
  final String? commentId;
  final String? postId;
  final String? username;

  CommentModel toModel() {
    return CommentModel(
      userId: userId,
      comment: comment,
      dateTime: dateTime,
      commentId: commentId,
      postId: postId,
      username: username,
    );
  }
}
