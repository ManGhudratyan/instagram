import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/mixins/comment_mixin.dart';
import '../../models/comment/comment_model.dart';
import 'comments_service.dart';

class CommentsServiceImp with CommentMixin implements CommentsService {
  CommentsServiceImp({
    required this.firebaseDatabase,
    required this.firebaseStorage,
  });
  @override
  final FirebaseDatabase firebaseDatabase;
  final FirebaseStorage firebaseStorage;

  @override
  Future<List<CommentModel>> getComments() async {
    final event = await commentsDatabaseReference.once();
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
    await commentsDatabaseReference.push().set(model.toJson());
  }

  @override
  Stream<DatabaseEvent> onChildAdded() =>
      commentsDatabaseReference.onChildAdded;

  @override
  Stream<DatabaseEvent> onChildChanged() =>
      commentsDatabaseReference.onChildChanged;
}
