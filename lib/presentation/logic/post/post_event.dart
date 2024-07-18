part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent({this.postEntity, this.userId, this.postId});
  final PostEntity? postEntity;
  final String? userId;
  final String? postId;

  @override
  List<Object?> get props => [userId, postEntity];
}

final class SavePostToDbEvent extends PostEvent {
  const SavePostToDbEvent(PostEntity postEntity)
      : super(postEntity: postEntity);
}

final class GetPostsFromCollectionEvent extends PostEvent {}

final class DeletePostDataEvent extends PostEvent {
  const DeletePostDataEvent(String userId) : super(userId: userId);
}

class UploadPostEvent extends PostEvent {
  const UploadPostEvent(this.postId, this.file);
  final String postId;
  final File file;
}
