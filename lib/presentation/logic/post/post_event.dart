part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent({this.postEntity, this.userId});
  final PostEntity? postEntity;
  final String? userId;

  @override
  List<Object?> get props => [userId, postEntity];
}

final class SavePostToDbEvent extends PostEvent {
  const SavePostToDbEvent(PostEntity postEntity)
      : super(postEntity: postEntity);
}

final class GetPostDataEvent extends PostEvent {
  const GetPostDataEvent(String userId) : super(userId: userId);
}

final class DeletePostDataEvent extends PostEvent {
  const DeletePostDataEvent(String userId) : super(userId: userId);
}

class UploadPostEvent extends PostEvent {
  const UploadPostEvent(this.postId, this.file);
  final String postId;
  final File file;
}
