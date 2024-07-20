import 'package:firebase_database/firebase_database.dart';

import '../../domain/repositories/comment_repository.dart';
import '../models/comment/comment_model.dart';
import '../services/comments/comments_service.dart';

class CommentRepositoryImp implements CommentRepository {
  CommentRepositoryImp(this.commentsService);

  final CommentsService commentsService;

  @override
  Future<List<CommentModel>> getComments() {
    return commentsService.getComments();
  }

  @override
  Stream<DatabaseEvent> onChildAdded() {
    return commentsService.onChildAdded();
  }

  @override
  Stream<DatabaseEvent> onChildChanged() {
    return commentsService.onChildChanged();
  }

  @override
  Future<void> sendComment(CommentModel model) {
    return commentsService.sendComment(model);
  }
}
