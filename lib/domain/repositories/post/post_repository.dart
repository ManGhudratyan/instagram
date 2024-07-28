import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/models/post/post_model.dart';
import '../../entities/post_entity.dart';

abstract class PostRepository {
  Future<void> savePostsToDB(PostEntity postEntity);
  Future<void> deletePostFromDB(String postId);
  Future<PostModel> getPostFromDB(String postId);
  Future<void> updatePostFromDB(PostModel postModel);
  Future<void> uploadPictureToDB(String postId, File file);
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsFromCollection();
  Future<List<DocumentSnapshot<Object?>>> getCommentsForPost(String postId);
}
