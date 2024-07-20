import '../../data/models/comment/comment_model.dart';

class CommentEntity {
  CommentEntity({this.userId, this.message, this.messageId});

  factory CommentEntity.fromModel(CommentModel model) => CommentEntity(
        userId: model.userId,
        message: model.message,
        messageId: model.messageId,
      );
  final String? userId;
  final String? message;
  final String? messageId;


  CommentModel toModel() => CommentModel(userId: userId, message: message);
}
