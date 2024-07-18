import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user/user_model.dart';
import 'user_service.dart';

class UserServiceImp extends UserService {
  UserServiceImp(
      this.firebaseFirestore, this.firebaseStorage, this.firebaseAuth);

  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;

  @override
  Future<void> saveUserToDB(UserModel userModel) async {
    await firebaseFirestore
        .collection('users')
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  @override
  Future<void> uploadProfilePicture(String userId, File file) async {
    final ref = firebaseStorage.ref('users_photos/').child(
          Timestamp.now().millisecondsSinceEpoch.toString() +
              ('.${file.path.split('.').lastOrNull ?? 'png'}'),
        );
    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();
    await firebaseFirestore.collection('users').doc(userId).update(
      {'profileImage': downloadUrl},
    );
  }

  @override
  Future<UserModel> getUserFromDb(String userId) async {
    final snapshot =
        await firebaseFirestore.collection('users').doc(userId).get();
    final userData = UserModel.fromJson(snapshot.data() ?? {});
    return userData;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersFromCollection() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Future<String> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception('No user logged in');
    }
  }
}
