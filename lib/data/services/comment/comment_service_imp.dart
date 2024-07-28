import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/mixin/comment_mixin.dart';
import '../../models/message/comment_model.dart';
import 'comment_service.dart';

class CommentServiceImp with CommentMixin implements CommentService {
  CommentServiceImp({
    required this.firebaseDatabase,
    required this.firebaseStorage,
  });
  
  @override
  final FirebaseDatabase firebaseDatabase;
  final FirebaseStorage firebaseStorage;

  DatabaseReference _getCommentReference(String postId) {
    return firebaseDatabase.ref('posts/$postId/comments');
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    final event = await _getCommentReference(postId).once();
    return event.snapshot.children
        .map(
          (e) => CommentModel.fromJson(
            (Map<String, dynamic>.from(
              e.value as Map<dynamic, dynamic>? ?? <String, dynamic>{},
            ))
              ..addAll({'commentId': e.key}),
          ),
        )
        .toList();
  }

  @override
  Future<void> sendComment(String postId, CommentModel model) async {
    await _getCommentReference(postId).push().set(model.toJson());
  }

  @override
  Future<void> sendMedia(String postId, File file) async {
    final ref = firebaseStorage.ref('sharedMedias/').child(
        '${Timestamp.now().millisecondsSinceEpoch}.${file.absolute.path.split('.').lastOrNull ?? 'mp4'}');
    await ref.putFile(file);
  }

  @override
  Stream<DatabaseEvent> onChildAdded(String postId) {
    return _getCommentReference(postId).onChildAdded;
  }

  @override
  Stream<DatabaseEvent> onChildChanged(String postId) {
    return _getCommentReference(postId).onChildChanged;
  }
}
