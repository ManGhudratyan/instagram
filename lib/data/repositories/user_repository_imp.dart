import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../services/user/user_service.dart';

class UserRepositoryImp implements UserRepository {
  UserRepositoryImp(this.userService);
  final UserService userService;

  @override
  Future<void> saveUserToDB(UserEntity userEntity) async {
    await userService.saveUserToDB(userEntity.toModel());
  }

  @override
  Future<void> uploadProfilePicture(String userId, File file) async {
    await userService.uploadProfilePicture(userId, file);
  }

  @override
  Future<UserEntity> getUserFromDb(String userId) async {
    return UserEntity.fromModel(await userService.getUserFromDb(userId));
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersFromCollection() {
    return userService.getUsersFromCollection();
  }
}
