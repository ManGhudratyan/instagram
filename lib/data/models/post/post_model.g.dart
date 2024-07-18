// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      description: json['description'] as String?,
      userId: json['userId'] as String?,
      photoUrl: json['photoUrl'] as String?,
      postId: json['postId'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('postId', instance.postId);
  val['userId'] = instance.userId;
  val['photoUrl'] = instance.photoUrl;
  val['description'] = instance.description;
  return val;
}
