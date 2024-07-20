// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      userId: json['userId'] as String?,
      message: json['message'] as String?,
      messageId: json['messageId'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'message': instance.message,
      'messageId': instance.messageId,
    };
