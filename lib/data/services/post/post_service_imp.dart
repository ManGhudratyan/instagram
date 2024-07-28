import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/post/post_model.dart';
import 'post_service.dart';

class PostServiceImp implements PostService {
  PostServiceImp({
    required this.firebaseDatabase,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  final FirebaseDatabase firebaseDatabase;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  @override
  Future<void> savePostsToDB(PostModel postModel) async {
    await firebaseFirestore
        .collection('posts')
        .doc(postModel.postId)
        .set(postModel.toJson());
  }

  @override
  Future<void> deletePostFromDB(String postId) async {
    await firebaseFirestore.collection('posts').doc(postId).delete();
  }

  @override
  Future<PostModel> getPostFromDB(String postId) async {
    final snapshot =
        await firebaseFirestore.collection('posts').doc(postId).get();
    final userData = PostModel.fromJson(snapshot.data() ?? {});
    return userData;
  }

  @override
  Future<void> updatePostFromDB(PostModel postModel) async {
    await firebaseFirestore
        .collection('posts')
        .doc(postModel.userId)
        .update(postModel.toJson());
  }

  @override
  Future<void> uploadPictureToDB(String postId, File file) async {
    final ref = firebaseStorage.ref('posts_photos/').child(
          Timestamp.now().millisecondsSinceEpoch.toString() +
              ('.${file.path.split('.').lastOrNull ?? 'png'}'),
        );
    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();
    await firebaseFirestore.collection('posts').doc(postId).update(
      {'photoUrl': downloadUrl},
    );
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsFromCollection() {
    return FirebaseFirestore.instance.collection('posts').snapshots();
  }

  @override
  Future<List<DocumentSnapshot>> getCommentsForPost(String postId) async {
    try {
      final commentsCollection = firebaseFirestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('timestamp', descending: true);

      final querySnapshot = await commentsCollection.get();

      return querySnapshot.docs;
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }
}
