import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../entities/user_entity.dart';

abstract class UserRepository {
  Future<void> saveUserToDB(UserEntity userEntity);
  Future<void> uploadProfilePicture(String userId, File file);
  Future<UserEntity> getUserFromDb(String userId);
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersFromCollection();
  Future<void> addFollowersList(String userId, List<String> newFollowers);
  Future<void> removeFollower(String userId, String followerId);
  Future<void> addFollowingList(String userId, List<String> newFollowings);
  Future<void> removeFollowing(String userId, String followingId);
}
