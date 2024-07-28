import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import '../../../data/models/message/comment_model.dart';
import '../../entities/comment_entity.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> getComments(String postId);
  Future<void> sendComment(String postId, CommentEntity commentEntity);
  Future<void> sendMedia(String postId, File file);
  Stream<DatabaseEvent> onChildAdded(String postId);
}
