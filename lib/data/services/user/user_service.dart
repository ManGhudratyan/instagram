import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_entity.dart';
import '../../models/user/user_model.dart';

abstract class UserService {
  Future<void> saveUserToDB(UserModel userModel);
  Future<UserModel> getUserFromDb(String userId);
  Future<void> uploadProfilePicture(String userId, File file);
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersFromCollection();
  Future<String> getCurrentUser();
  Future<void> addFollowersList(String userId, List<String> newFollowers);
  Future<void> removeFollower(String userId, String followerId);
  Future<void> addFollowingsList(String userId, List<String> newFollowings);
  Future<void> removeFollowing(String userId, String followingId);
  Future<List<UserEntity>> getFollowingsList(String userId);
}
