import 'package:firebase_database/firebase_database.dart';

import '../../../data/models/comment/comment_model.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> getComments();
  Future<void> sendComment(CommentModel model);
  Stream<DatabaseEvent> onChildAdded();
  Stream<DatabaseEvent> onChildChanged();
}
