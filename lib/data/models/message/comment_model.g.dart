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
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'comment': instance.comment,
      'dateTime': instance.dateTime?.toIso8601String(),
      'commentId': instance.commentId,
    };
