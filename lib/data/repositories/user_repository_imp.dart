import 'dart:io';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
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
  Future<UserModel> getUserFromDb(String userId) async {
    return userService.getUserFromDb(userId);
}
}
