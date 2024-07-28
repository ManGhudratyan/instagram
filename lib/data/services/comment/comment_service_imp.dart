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

  @override
  Future<List<CommentModel>> getComments() async {
    final event = await commentDatabaseReference.once();
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
  Future<void> sendComment(CommentModel model) async {
    await commentDatabaseReference.push().set(model.toJson());
  }

  @override
  Future<void> sendMedia(File file) async {
    final ref = firebaseStorage.ref('sharedMedias/').child(
        '${Timestamp.now().millisecondsSinceEpoch}.${file.absolute.path.split('.').lastOrNull ?? 'mp4'}');
    await ref.putFile(file);
    print(await ref.getDownloadURL()); // TBD
  }

  @override
  Stream<DatabaseEvent> onChildAdded() {
    return commentDatabaseReference.onChildAdded;
  }

  @override
  Stream<DatabaseEvent> onChildChanged() {
    return commentDatabaseReference.onChildChanged;
  }
}
