import 'dart:io';

import '../../models/post/post_model.dart';

abstract class PostService {
  Future<void> savePostsToDB(PostModel postModel);
  Future<void> deletePostFromDB(String postId);
  Future<PostModel> getPostFromDB(String postId);
  Future<void> updatePostFromDB(PostModel postModel);
  Future<void> uploadPictureToDB(String postId, File file);
}
