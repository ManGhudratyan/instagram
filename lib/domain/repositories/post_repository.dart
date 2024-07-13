import 'dart:io';

import '../../data/models/post/post_model.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<void> savePostsToDB(PostEntity postEntity);
  Future<void> deletePostFromDB(String userId);
  Future<PostModel> getPostFromDB(String userId);
  Future<void> updatePostFromDB(PostModel postModel);
  Future<void> uploadPictureToDB(String postId, File file);
}
