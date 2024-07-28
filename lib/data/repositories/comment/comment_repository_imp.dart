import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

import '../../../domain/entities/comment_entity.dart';
import '../../../domain/repositories/comment/comment_repository.dart';
import '../../models/message/comment_model.dart';
import '../../services/comment/comment_service.dart';

class CommentRepositoryImp implements CommentRepository {
  CommentRepositoryImp({required this.commentService});
  final CommentService commentService;

  @override
  Future<List<CommentModel>> getComments(String postId) {
    return commentService.getComments(postId);
  }

  @override
  Stream<DatabaseEvent> onChildAdded(String postId) {
    return commentService.onChildAdded(postId);
  }

  @override
  Future<void> sendComment(String postId, CommentEntity commentEntity) {
    return commentService.sendComment(postId, commentEntity.toModel());
  }

  @override
  Future<void> sendMedia(String postId, File file) {
    return commentService.sendMedia(postId, file);
  }
}
