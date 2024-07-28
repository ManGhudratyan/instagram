import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import '../../comment/comment_entity.dart';

abstract class CommentRepository {
  Future<List<CommentEntity>> getComments();
  Future<void> sendMedia(File file);
  Future<void> sendComment(CommentEntity commentEntity);
  Stream<DatabaseEvent> onChildAdded();
  Stream<DatabaseEvent> onChildChanged();
}
