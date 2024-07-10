import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/user/user_model.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<void> saveUserToDB(UserEntity userEntity);
  Future<void> uploadProfilePicture(String userId, File file);
  Future<UserModel> getUserFromDb(String userId);
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersFromCollection();
}
