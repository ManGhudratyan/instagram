import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {

  CommentModel({this.userId, this.comment, this.dateTime, this.commentId});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  final String? userId;
  final String? comment;
  final DateTime? dateTime;
  final String? commentId;

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
