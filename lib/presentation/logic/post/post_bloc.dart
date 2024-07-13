import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.postRepository) : super(PostInitial()) {
    on<SavePostToDbEvent>(_mapSavePostToDbEventToState);
    on<GetPostDataEvent>(_mapGetPostDataEventToState);
    on<DeletePostDataEvent>(_mapDeletePostDataEventToState);
    on<UploadPostEvent>(_mapUploadPostEventToState);
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

  FutureOr<void> _mapGetPostDataEventToState(
      GetPostDataEvent event, Emitter<PostState> emit) async {
    try {
      emit(GetPostDataLoading(state));
      final posts =
          await postRepository.getPostFromDB(event.postEntity?.userId ?? '');
      emit(GetPostDataLoaded(posts.toModel(), state));
    } catch (error) {
      emit(GetPostDataFailed(error.toString(), state));
    }
  }

  FutureOr<void> _mapDeletePostDataEventToState(
      DeletePostDataEvent event, Emitter<PostState> emit) async {
    try {
      emit(DeletePostDataLoading());
      await postRepository.deletePostFromDB(event.userId ?? '');
      emit(DeletePostDataSuccessed());
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
