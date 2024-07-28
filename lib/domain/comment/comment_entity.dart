import '../../data/models/message/comment_model.dart';

class CommentEntity {
  CommentEntity({this.userId, this.comment, this.dateTime, this.commentId});

  factory CommentEntity.fromModel(CommentModel model) => CommentEntity(
        userId: model.userId,
        comment: model.comment,
        dateTime: model.dateTime,
        commentId: model.commentId,
      );
  final String? userId;
  final String? comment;
  final DateTime? dateTime;
  final String? commentId;

  CommentModel toModel() {
    return CommentModel(userId: userId, comment: comment, dateTime: dateTime);
  }
}
