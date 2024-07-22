// ignore_for_file: overridden_fields

part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent({this.postEntity, this.userId, this.postId});
  final PostEntity? postEntity;
  final String? userId;
  final String? postId;

  @override
  List<Object?> get props => [userId, postEntity, postId];
}

final class SavePostToDbEvent extends PostEvent {
  const SavePostToDbEvent(PostEntity postEntity)
      : super(postEntity: postEntity);
}

final class GetPostsFromCollectionEvent extends PostEvent {}

final class DeletePostDataEvent extends PostEvent {

  const DeletePostDataEvent(this.postId) : super();
  @override
  final String postId;

  @override
  List<Object> get props => [postId];
}


class UploadPostEvent extends PostEvent {
  const UploadPostEvent(this.postId, this.file);
  @override
  final String postId;
  final File file;
}

class GetCommentsForPostEvent extends PostEvent {
  const GetCommentsForPostEvent(this.postId);
  @override
  final String postId;

  @override
  List<Object?> get props => [postId];
}
