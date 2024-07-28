import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/post/post_model.dart';

class PostEntity {
  PostEntity({
    this.description,
    required this.userId,
    this.photoUrl,
    String? postId,
  }) : postId = postId ?? Uuid().v4();

  factory PostEntity.fromModel(PostModel postModel) {
    return PostEntity(
      userId: postModel.userId,
      photoUrl: postModel.photoUrl,
      description: postModel.description,
      postId: postModel.postId,
    );
  }

  @JsonKey(includeIfNull: false)
  final String? postId;
  final String? userId;
  final String? photoUrl;
  final String? description;

  PostModel toModel() {
    return PostModel(
      userId: userId,
      photoUrl: photoUrl,
      description: description,
      postId: postId,
    );
  }
}
