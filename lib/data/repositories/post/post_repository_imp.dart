import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/repositories/post/post_repository.dart';
import '../../models/post/post_model.dart';
import '../../services/post/post_service.dart';

class PostRepositoryImp extends PostRepository {
  PostRepositoryImp({required this.postService});

  final PostService postService;

  @override
  Future<void> savePostsToDB(PostEntity postEntity) async {
    await postService.savePostsToDB(postEntity.toModel());
  }

  @override
  Future<void> deletePostFromDB(String postId) async {
    await postService.deletePostFromDB(postId);
  }

  @override
  Future<PostModel> getPostFromDB(String postId) {
    return postService.getPostFromDB(postId);
  }

  @override
  Future<void> updatePostFromDB(PostModel postModel) {
    return postService.updatePostFromDB(postModel.toModel());
  }

  @override
  Future<void> uploadPictureToDB(String postId, File file) {
    return postService.uploadPictureToDB(postId, file);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsFromCollection() {
    return postService.getPostsFromCollection();
  }

}
