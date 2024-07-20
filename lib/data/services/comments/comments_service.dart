import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import '../../models/comment/comment_model.dart';

abstract class CommentsService {
  Future<List<CommentModel>> getComments();
  Future<void> sendComment(CommentModel model);
  Stream<DatabaseEvent> onChildAdded();
  Stream<DatabaseEvent> onChildChanged();
}
