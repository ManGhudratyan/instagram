import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/post_entity.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends PostEntity {
  PostModel({
    super.description,
    required super.userId,
    super.photoUrl,
    required super.postId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
