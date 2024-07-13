import 'dart:io';

import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post/post_model.dart';
import '../services/post/post_service.dart';

class PostRepositoryImp extends PostRepository {
  PostRepositoryImp({required this.postService});

  final PostService postService;

  @override
  Future<void> savePostsToDB(PostEntity postEntity) async {
    await postService.savePostsToDB(postEntity.toModel());
  }

  @override
  Future<void> deletePostFromDB(String userId) async {
    await postService.deletePostFromDB(userId);
  }

  @override
  Future<PostModel> getPostFromDB(String userId) {
    return postService.getPostFromDB(userId);
  }

  @override
  Future<void> updatePostFromDB(PostModel postModel) {
    return postService.updatePostFromDB(postModel.toModel());
  }

  @override
  Future<void> uploadPictureToDB(String postId, File file) {
    return postService.uploadPictureToDB(postId, file);
  }
}
