// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      userId: json['userId'] as String?,
      comment: json['comment'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      commentId: json['commentId'] as String?,
      postId: json['postId'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'comment': instance.comment,
      'dateTime': instance.dateTime?.toIso8601String(),
      'commentId': instance.commentId,
      'postId': instance.postId,
      'username': instance.username,
    };
