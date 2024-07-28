import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import '../../models/message/comment_model.dart';

abstract class CommentService {
  Future<List<CommentModel>> getComments(String postId);
  Future<void> sendComment(String postId, CommentModel model);
  Future<void> sendMedia(String postId, File file);
  Stream<DatabaseEvent> onChildAdded(String postId);
  Stream<DatabaseEvent> onChildChanged(String postId);
}
