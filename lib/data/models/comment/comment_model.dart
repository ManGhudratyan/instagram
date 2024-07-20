import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/comment_entity.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends CommentEntity {
  CommentModel({
    super.userId,
    super.comment,
    super.commentId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
