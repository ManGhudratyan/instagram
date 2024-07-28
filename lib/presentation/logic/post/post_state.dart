part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState({
    this.error,
    this.postEntity,
    this.posts,
    //  this.postComments,
  });

  final String? error;
  final PostEntity? postEntity;
  final List<PostEntity>? posts;
  // final Map<String, List<CommentModel>>? postComments;

  @override
  List<Object?> get props => [error, postEntity, posts];
}

final class PostInitial extends PostState {}

final class SavePostToDbLoading extends PostState {
  SavePostToDbLoading(PostState initState)
      : super(postEntity: initState.postEntity, posts: initState.posts);
}

final class SavePostToDbLoaded extends PostState {
  SavePostToDbLoaded(PostState initState)
      : super(postEntity: initState.postEntity, posts: initState.posts);
}

final class SavePostToDbFailed extends PostState {
  SavePostToDbFailed(String error, PostState initState)
      : super(error: error, postEntity: initState.postEntity);
}

final class GetPostDataLoading extends PostState {
  GetPostDataLoading(PostState initState)
      : super(postEntity: initState.postEntity, posts: initState.posts);
}

final class GetPostDataLoaded extends PostState {
  GetPostDataLoaded(PostEntity postEntity, PostState initState)
      : super(postEntity: postEntity, posts: initState.posts);
}

final class GetPostDataFailed extends PostState {
  GetPostDataFailed(String error, PostState initState)
      : super(
            error: error,
            postEntity: initState.postEntity,
            posts: initState.posts);
}

final class DeletePostDataSuccessed extends PostState {
  DeletePostDataSuccessed(PostState initState)
      : super(
          postEntity: initState.postEntity,
          posts: initState.posts,
        );
}

final class DeletePostDataLoading extends PostState {}

final class DeletePostDataFailed extends PostState {
  const DeletePostDataFailed(String error) : super(error: error);
}

final class PostFailed extends PostState {
  PostFailed(PostState initialState, String error)
      : super(postEntity: initialState.postEntity, error: error);
}

final class PostLoading extends PostState {
  PostLoading(PostState initialState)
      : super(postEntity: initialState.postEntity);
}

final class PostLoaded extends PostState {
  PostLoaded(PostEntity? postEntity, PostState initState)
      : super(postEntity: postEntity, posts: initState.posts);
}

final class GetPostFromCollectionLoaded extends PostState {
  GetPostFromCollectionLoaded(
    PostState initState,
    List<PostEntity> posts,
  ) : super(
          posts: posts,
          postEntity: initState.postEntity,
        );
}

final class GetPostFromCollectionLoading extends PostState {
  GetPostFromCollectionLoading(PostState initialState)
      : super(postEntity: initialState.postEntity);
}

final class GetPostFromCollectionFailed extends PostState {
  GetPostFromCollectionFailed(String error, PostState initState)
      : super(
          error: error,
          postEntity: initState.postEntity,
          posts: initState.posts,
        );
}
