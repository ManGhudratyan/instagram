import '../../data/models/comment/comment_model.dart';

class CommentEntity {
  CommentEntity({this.userId, this.comment, this.commentId});

  factory CommentEntity.fromModel(CommentModel model) => CommentEntity(
        userId: model.userId,
        comment: model.comment,
        commentId: model.commentId,
      );
  final String? userId;
  final String? comment;
  final String? commentId;


  CommentModel toModel() => CommentModel(userId: userId, comment: comment);
}
