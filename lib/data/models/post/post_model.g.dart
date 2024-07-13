// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      description: json['description'] as String?,
      userId: json['userId'] as String,
      photoUrl: json['photoUrl'] as String?,
      postId: json['postId'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
    };
