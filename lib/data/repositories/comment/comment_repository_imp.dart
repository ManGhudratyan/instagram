import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

import '../../../domain/comment/comment_entity.dart';
import '../../../domain/repositories/comment/comment_repository.dart';
import '../../services/comment/comment_service.dart';

class CommentRepositoryImp implements CommentRepository {
  CommentRepositoryImp({required this.commentService});
  final CommentService commentService;

  @override
  Future<List<CommentEntity>> getComments() async {
    final comments = await commentService.getComments();
    return comments.map(CommentEntity.fromModel).toList();
  }

  @override
  Future<void> sendComment(CommentEntity commentEntity) async {
    await commentService.sendComment(commentEntity.toModel());
  }

  @override
  Future<void> sendMedia(File file) async {
    return commentService.sendMedia(file);
  }

  @override
  Stream<DatabaseEvent> onChildAdded() {
    return commentService.onChildAdded();
  }

  @override
  Stream<DatabaseEvent> onChildChanged() {
    return commentService.onChildChanged();
  }
}
