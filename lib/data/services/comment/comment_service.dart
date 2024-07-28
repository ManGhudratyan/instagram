import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import '../../models/message/comment_model.dart';

abstract class CommentService {
  Future<List<CommentModel>> getComments();
  Future<void> sendMedia(File file);
  Future<void> sendComment(CommentModel model);
  Stream<DatabaseEvent> onChildAdded();
  Stream<DatabaseEvent> onChildChanged();
}
