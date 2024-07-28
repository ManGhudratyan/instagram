import 'package:json_annotation/json_annotation.dart';

import '../../../domain/comment/comment_entity.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends CommentEntity {
  CommentModel({
    super.userId,
    super.comment,
    super.dateTime,
    super.commentId,
    super.postId,
    super.username,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
