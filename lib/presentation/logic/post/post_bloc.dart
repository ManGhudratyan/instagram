import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/comment/comment_model.dart';
import '../../../data/models/post/post_model.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/repositories/post/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.postRepository) : super(PostInitial()) {
    on<SavePostToDbEvent>(_mapSavePostToDbEventToState);
    on<DeletePostDataEvent>(_mapDeletePostDataEventToState);
    on<UploadPostEvent>(_mapUploadPostEventToState);
    on<GetPostsFromCollectionEvent>(_mapGetPostsFromCollectionEventToState);
    on<GetCommentsForPostEvent>(_mapGetCommentsForPostEventToState);
  }

  final PostRepository postRepository;
  FutureOr<void> _mapSavePostToDbEventToState(
      SavePostToDbEvent event, Emitter<PostState> emit) async {
    try {
      emit(SavePostToDbLoading(state));
      await postRepository.savePostsToDB(event.postEntity!);
      emit(SavePostToDbLoaded(state));
    } catch (error) {
      emit(SavePostToDbFailed(error.toString(), state));
    }
  }

  FutureOr<void> _mapGetPostsFromCollectionEventToState(
      GetPostsFromCollectionEvent event, Emitter<PostState> emit) async {
    try {
      emit(GetPostFromCollectionLoading(state));
      final postSnapshot = postRepository.getPostsFromCollection();
      final postComments = <String, List<CommentModel>>{};

      await for (final snapshot in postSnapshot) {
        final posts =
            snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();

        for (final post in posts) {
          final comments =
              await postRepository.getCommentsForPost(post.postId ?? '');
          postComments[post.postId ?? ''] = comments
              .map((doc) =>
                  CommentModel.fromJson(doc.data()! as Map<String, dynamic>))
              .toList();
        }

        emit(GetPostFromCollectionLoaded(state, posts, postComments));
      }
    } catch (error) {
      emit(GetPostFromCollectionFailed(error.toString(), state));
    }
  }

  FutureOr<void> _mapGetCommentsForPostEventToState(
      GetCommentsForPostEvent event, Emitter<PostState> emit) async {
    try {
      final comments = await postRepository.getCommentsForPost(event.postId);
      emit(GetCommentsForPostLoaded(
        event.postId,
        comments
            .map((doc) =>
                CommentModel.fromJson(doc.data()! as Map<String, dynamic>))
            .toList(),
      ));
    } catch (error) {
      emit(GetPostDataFailed(error.toString(), state));
    }
  }

  FutureOr<void> _mapDeletePostDataEventToState(
      DeletePostDataEvent event, Emitter<PostState> emit) async {
    try {
      emit(DeletePostDataLoading());
      final postId = event.postId;
      if (postId.isEmpty) {
        throw Exception('Post ID is empty');
      }
      await postRepository.deletePostFromDB(postId);
      emit(DeletePostDataSuccessed(state));
    } catch (error) {
      emit(DeletePostDataFailed(error.toString()));
    }
  }

  FutureOr<void> _mapUploadPostEventToState(
      UploadPostEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostLoading(state));
      await postRepository.uploadPictureToDB(event.postId, event.file);
      emit(PostLoaded(state.postEntity, state));
    } catch (e) {
      emit(PostFailed(state, e.toString()));
    }
  }
}
